class AddLinkAndExplanationToVotes < ActiveRecord::Migration
  def self.up
    add_column :votes, :link, :string
    add_column :votes, :explanation, :text
  end

  def self.down
    remove_column :votes, :explanation
    remove_column :votes, :link
  end
end
