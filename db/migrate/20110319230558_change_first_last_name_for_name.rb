class ChangeFirstLastNameForName < ActiveRecord::Migration
  def self.up
    remove_column :users, :first_name
    remove_column :users, :last_name
    add_column :users, :name, :string 
  end

  def self.down
    remove_column :users, :name
    add_column :users, :last_name, :string
    add_column :users, :first_name, :string
  end
end