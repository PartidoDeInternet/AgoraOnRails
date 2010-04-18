class AddVisitsToProposals < ActiveRecord::Migration
  def self.up
    add_column :proposals, :visits, :integer, :default => 0
  end

  def self.down
    remove_column :proposals, :visits
  end
end
