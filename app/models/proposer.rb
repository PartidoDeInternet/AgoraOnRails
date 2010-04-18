class Proposer < ActiveRecord::Base
  has_many :proposals
  
  before_create :set_name, :unless => :name
  
  named_scope :hot, :order => "proposals_count DESC", :limit => 5
  
  def set_name
    self.name = full_name
  end
  
end
