class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :votes
  has_many :voted_proposals, :through => :votes, :source => :proposal
  belongs_to :spokesman, :class_name => "User", :counter_cache => :represented_users_count
  has_many :represented_users, :class_name => "User", :foreign_key => :spokesman_id
  
  def name
    "#{first_name} #{last_name}"
  end
  
  def has_voted_for?(proposal)
    voted_proposals.include?(proposal)
  end
    
  def delegated_vote_for(proposal)
    return nil if has_voted_for?(proposal) or spokesman.nil? 
    
    spokesman.vote_for(proposal)
  end
  
  def vote_for(proposal)
    if has_voted_for?(proposal) 
      votes.find_by_proposal_id(proposal)
    else
      spokesman.vote_for(proposal) if spokesman.present?
    end
  end
  
  def voted_and_delegated_proposals
    voted_proposals + (spokesman.try(:voted_and_delegated_proposals) || [])
  end

end