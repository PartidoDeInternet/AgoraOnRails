class AdminUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :admin, :boolean, :default => false
    add_column :proposals, :closer_id, :integer
  end

  def self.down
    remove_column :users, :admin
    remove_column :proposals, :closer_id
  end
end
