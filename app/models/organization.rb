class Organization < ActiveRecord::Base
  attr_accessible :name, :description, :spokesman
  has_many :represented_users, :class_name => "User", :foreign_key => :representer_id
  belongs_to :spokesman, :class_name => "User"
  has_many :opinions
end
