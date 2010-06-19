class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :votes
  has_many :voted_proposals, :through => :votes, :source => :proposal
  belongs_to :organization
  
  def has_voted_for?(proposal)
    voted_proposals.include?(proposal)
  end 
end