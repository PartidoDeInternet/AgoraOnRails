class AddProposerCountToProposals < ActiveRecord::Migration
  def self.up
    add_column :proposers, :proposals_count, :integer
  end

  def self.down
    remove_column :proposers, :proposals_count
  end
end
