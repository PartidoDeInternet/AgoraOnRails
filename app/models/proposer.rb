class Proposer < ActiveRecord::Base
  has_many :proposals
  
  before_create :set_name, :unless => :name
  
  def set_name
    self.name = full_name
  end
  
end
