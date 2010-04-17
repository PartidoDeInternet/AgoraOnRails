class Vote < ActiveRecord::Base
  belongs_to :proposal
  belongs_to :user
  
  validates_uniqueness_of :proposal_id, :scope => :user_id
end
