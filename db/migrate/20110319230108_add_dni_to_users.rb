class AddDniToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :dni, :string
  end

  def self.down
    remove_column :users, :dni
  end
end
