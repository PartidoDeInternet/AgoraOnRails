# coding: utf-8
class Category < ActiveRecord::Base
  has_many :proposals
  
  before_create :set_name
  
  scope :hot, -> { order("proposals_count DESC").limit(5) }

  def set_name
    if commission_name and name.nil?
      self.name = upcase_first(commission_name.gsub(/Comisión( Mixta)?( del?| para las?)? /, "")) 
    end
  end
  
  private
  
  def upcase_first(string)
    string[0..0].upcase + string[1..-1]
  end
end
