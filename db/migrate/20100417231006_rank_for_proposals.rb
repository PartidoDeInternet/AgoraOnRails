class RankForProposals < ActiveRecord::Migration
  def self.up
    add_column :proposals, :ranking, :integer, :default => 0
  end

  def self.down
    remove_column :proposals, :ranking
  end
end
