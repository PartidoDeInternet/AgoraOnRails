class Opinion < ActiveRecord::Base
  belongs_to :proposal
  belongs_to :organization
  
  validates_uniqueness_of :proposal_id, :scope => :organization_id
  
end
