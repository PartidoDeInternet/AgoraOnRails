class RemovePersonalDataFromUsers < ActiveRecord::Migration
  def self.up
    rename_column :users, :dni, :login
    remove_column :users, :first_name
    remove_column :users, :last_name
    Vote.delete_all
    User.delete_all
  end

  def self.down
    add_column :users, :last_name, :string,                         :null => false
    add_column :users, :first_name, :string,                        :null => false
    rename_column :users, :login, :dni
  end
end
