class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :votes
  has_many :voted_proposals, :through => :votes, :source => :proposal
  belongs_to :spokesman, :class_name => "User"
  has_many :represented_users, :class_name => "User", :foreign_key => :spokesman_id
  
  def name
    "#{first_name} #{last_name}"
  end
  
  def has_voted_for?(proposal)
    voted_proposals.include?(proposal)
  end
    
  def delegated_vote_for(proposal)
    return nil if has_voted_for?(proposal) or spokesman.nil? 
    spokesman.has_voted_for?(proposal) ? spokesman.votes.find_by_proposal_id(proposal) : nil
  end

end