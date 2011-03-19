class Vote < ActiveRecord::Base
  belongs_to :proposal
  belongs_to :user
  
  scope :order_by_represented_users, order("users.represented_users_count DESC").includes("user")
  
  validates_uniqueness_of :proposal_id, :scope => :user_id
  
  after_create :update_results
  
  def update_results
    proposal.count_votes!
  end
  
  def self.choices
    ["in_favor", "against", "abstention"]
  end

end
