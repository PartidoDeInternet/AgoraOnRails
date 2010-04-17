class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.login_field = :dni
  end
  
  has_many :votes
  has_many :voted_proposals, :through => :votes, :source => :proposal
  
  def has_voted_for?(proposal)
    voted_proposals.include?(proposal)
  end 
end