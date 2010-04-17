class VotesInFavorAgainstForProposals < ActiveRecord::Migration
  def self.up
    add_column :proposals, :in_favor, :integer, :default => 0
    add_column :proposals, :against, :integer, :default => 0
    add_column :proposals, :abstention, :integer, :default => 0
  end

  def self.down
    remove_column :proposals, :abstention
    remove_column :proposals, :votes_against
    remove_column :proposals, :votes_in_favor
  end
end
