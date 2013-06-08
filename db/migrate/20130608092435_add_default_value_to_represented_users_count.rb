class AddDefaultValueToRepresentedUsersCount < ActiveRecord::Migration
  def up
    change_column :users, :represented_users_count, :integer, :default => 0
  end

  def down
    change_column :users, :represented_users_count, :integer, :default => nil
  end
end
