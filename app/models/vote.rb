class Vote < ActiveRecord::Base
  belongs_to :proposal
  belongs_to :user
  
  attr_accessor :value
  
  validates_uniqueness_of :proposal_id, :scope => :user_id
  
  after_create :update_results, :update_ranking
  
  def update_results
    case value
    when "si": proposal.in_favor += 1
    when "no": proposal.against += 1
    when "abstencion": proposal.abstention += 1
    end
    proposal.save!
  end
  
  def update_ranking
    proposal.ranking += 3
    proposal.save!
  end
  
  def self.choices
    ["in_favor", "against", "abstention"]
  end
  
end
