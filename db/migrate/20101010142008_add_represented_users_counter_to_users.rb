class AddRepresentedUsersCounterToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :represented_users_count, :integer
  end

  def self.down
    remove_column :users, :represented_users_count
  end
end
