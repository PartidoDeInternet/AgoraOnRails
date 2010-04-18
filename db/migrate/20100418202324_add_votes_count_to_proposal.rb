class AddVotesCountToProposal < ActiveRecord::Migration
  def self.up
    add_column :proposals, :votes_count, :integer
  end

  def self.down
    remove_column :proposals, :votes_count
  end
end
