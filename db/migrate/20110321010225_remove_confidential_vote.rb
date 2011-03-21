class RemoveConfidentialVote < ActiveRecord::Migration
  def self.up
    remove_column :votes, :confidential
  end

  def self.down
    add_column :votes, :confidential, :boolean, :default=> false
  end
end
