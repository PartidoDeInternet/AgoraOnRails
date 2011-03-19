class AddConfidentialToVotes < ActiveRecord::Migration
  def self.up
    add_column :votes, :confidential, :boolean, :default=> false
  end

  def self.down
    remove_column :votes, :confidential
  end
end
