class DelegatedVote < ActiveRecord::Base
  belongs_to :proposal

  def reset!
    self.in_favor = 0
    self.against = 0
    self.abstention = 0
    self.save!
  end
end
