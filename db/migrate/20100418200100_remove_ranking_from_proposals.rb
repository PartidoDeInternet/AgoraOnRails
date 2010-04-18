class RemoveRankingFromProposals < ActiveRecord::Migration
  def self.up
    remove_column :proposals, :ranking
  end

  def self.down
    add_column :proposals, :ranking, :integer, :default => 0
  end
end
