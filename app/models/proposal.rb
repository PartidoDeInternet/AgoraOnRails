class Proposal < ActiveRecord::Base
  has_many :votes
  belongs_to :category, :counter_cache => true
  belongs_to :proposer, :counter_cache => true
  has_one :delegated_vote
  
  scope :open, where("closed_at is null")
  scope :hot,  order("(visits + votes_count * 3) DESC").limit(5)
  scope :recently_closed, where("closed_at is not null and official_resolution is not null").order("closed_at DESC").limit(5)
  scope :staff_choice, where("position is not null").order("position ASC").limit(5)
  
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
  
  def count_delegated_votes!
    delegated_vote.reset!
    
    User.all.each do |user|
      vote = user.delegated_vote_for(self)
      if vote    
        case vote.value
        when "si" then delegated_vote.in_favor += 1
        when "no" then delegated_vote.against += 1
        when "abstencion" then delegated_vote.abstention += 1
        end
        delegated_vote.save!
      end
    end
  end
    
  def total_votes
    self.total_in_favor + self.total_against + self.total_abstention
  end
  
  def total_in_favor
    self.in_favor + self.delegated_vote.in_favor
  end
  
  def total_against
    self.against + self.delegated_vote.against
  end
  
  def total_abstention
    self.abstention + self.delegated_vote.abstention
  end
  
  def proposer_name
    proposer.name
  end
  
  def category_name
    category.name
  end
end
