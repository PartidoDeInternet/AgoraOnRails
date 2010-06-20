class Proposal < ActiveRecord::Base
  has_many :votes
  belongs_to :category, :counter_cache => true
  belongs_to :proposer, :counter_cache => true
  has_many :opinions
  
  named_scope :open, :conditions => "closed_at is null"
  named_scope :hot,  :order => "(visits + votes_count * 3) DESC", :limit => 5
  named_scope :recently_closed, :conditions => "closed_at is not null and official_resolution is not null", :order => "closed_at DESC", :limit => 5
  
  def closed?
    closed_at.present?
  end
  
  #choices can be in_favor, against or abstention
  def percentage_for(choice)
    vote_choice = self.send(choice)
    vote_choice > 0 ? (vote_choice.to_f / votes.count * 100) : 0  
  end
  
  def visited!
    Proposal.increment_counter :visits, id
  end
    
end
