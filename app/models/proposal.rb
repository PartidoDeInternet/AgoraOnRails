class Proposal < ActiveRecord::Base
  default_scope { order 'proposed_at DESC' }

  has_many :votes
  belongs_to :category, :counter_cache => true
  belongs_to :proposer, :counter_cache => true
  
  scope :open,            -> { where("closed_at is null") }
  scope :hot,             -> { open.order("votes_count desc, visits desc").limit(5) }
  scope :recently_closed, -> { where("closed_at is not null and status is not null").order("closed_at DESC").limit(5) }
  
  after_create :set_delegated_vote
  
  def set_delegated_vote
    DelegatedVote.create!(:proposal => self)
  end
  
  def closed?
    closed_at.present?
  end
  
  #choices can be in_favor, against or abstention
  def percentage_for(choice)
    vote_choice = self.send("total_#{choice}")
    vote_choice > 0 ? (vote_choice.to_f / total_votes * 100) : 0  
  end
  
  def visited!
    Proposal.increment_counter :visits, id
  end
  
  def count_votes!
    self.in_favor = 0
    self.against = 0
    self.abstention = 0
    
    User.all.each do |user|
      if vote = user.vote_for(self)    
        case vote.value
        when "si" then self.in_favor += 1
        when "no" then self.against += 1
        when "abstencion" then self.abstention += 1
        end
      end
    end
    
    save!
  end
    
  def total_votes
    self.total_in_favor + self.total_against + self.total_abstention
  end
  
  def total(choice)
    self.send(choice)
  end
  
  def total_representatives(choice, representative_count)
    return 0 if total_votes == 0 
    percentage = self.send(choice).to_f / total_votes
    (percentage * representative_count.to_f).floor
  end
  
  #syntatic sugar compatibility layer
  Vote.choices.each do |choice|
    define_method "total_#{choice}" do
      total(choice)
    end
  
  #syntactic sugar compatibility layer
    define_method "total_representatives_#{choice}" do |representative_count|
      total_representatives(choice, representative_count)
    end
  end
    
  def proposer_name
    proposer.name
  end
  
  def category_name
    category.name
  end
  
  def closed?
    closed_at.present?
  end
  
  def open?
    closed_at.blank?
  end

  def close(cid)
    self.closed_at = DateTime.now
    self.closer_id = cid
    self.save!
    count_votes!
  end
end
