class Vote < ActiveRecord::Base
  belongs_to :proposal
  belongs_to :user
  
  scope :order_by_represented_users, order("users.represented_users_count DESC").includes("user")
  scope :public, where("votes.confidential = ?",false)
  scope :confidential, where("votes.confidential = ?",true)
  
  validates_uniqueness_of :proposal_id, :scope => :user_id
  
  after_create :update_results
  
  def update_results
    case value
    when "si" then proposal.in_favor += 1
    when "no" then proposal.against += 1
    when "abstencion" then proposal.abstention += 1
    end
    proposal.save!
  end
  
  def self.choices
    ["in_favor", "against", "abstention"]
  end
  
  def public?
    !confidential
  end
  
  def confidential?
    confidential
  end

end
