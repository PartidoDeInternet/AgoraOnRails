class FinishedBooleanForProposals < ActiveRecord::Migration
  def self.up
    add_column :proposals, :closed, :boolean
  end

  def self.down
    remove_column :proposals, :closed
  end
end
