class AddProposedAtToProposals < ActiveRecord::Migration
  def self.up
    add_column :proposals, :proposed_at, :date
  end

  def self.down
    remove_column :proposals, :proposed_at
  end
end
