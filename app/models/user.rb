class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :votes
  has_many :voted_proposals, :through => :votes, :source => :proposal
  belongs_to :representer, :class_name => "Organization"
  has_one :represented_organization, :class_name => "Organization", :foreign_key => "spokesman_id"
  
  def name
    "#{first_name} #{last_name}"
  end
  
  def has_voted_for?(proposal)
    voted_proposals.include?(proposal)
  end
  
  def represents_organization?
    represented_organization
  end
  
  def delegated_opinion_for(proposal)
    return nil if has_voted_for?(proposal) or representer.nil? 
    representer.opinion_for(proposal)
  end

end