class RemoveClosedAttributeFromProposals < ActiveRecord::Migration
  def self.up
    remove_column :proposals, :closed
  end

  def self.down
    add_column :proposals, :closed, :boolean, :default => false
  end
end
