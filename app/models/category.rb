class Category < ActiveRecord::Base
  has_many :proposals
  
  before_create :set_name, :unless => :name
  
  named_scope :hot, :order => "proposals_count DESC", :limit => 5
  
  def set_name
    self.name = upcase_first(commission_name.gsub(/Comisión( Mixta)?( del?| para las?)? /, "")) if commission_name
  end
  
  private
  
  def upcase_first(string)
    string[0..0].upcase + string[1..-1]
  end
end
