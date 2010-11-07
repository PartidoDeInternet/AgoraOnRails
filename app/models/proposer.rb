class Proposer < ActiveRecord::Base
  has_many :proposals
  
  before_create :set_name
  
  scope :hot, order("proposals_count DESC").limit(5)
  
  def set_name
    self.name = full_name unless self.name
  end
  
end
