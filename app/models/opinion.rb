class Opinion < ActiveRecord::Base
  belongs_to :proposal
  belongs_to :organization
end
