class AddSpokesmanIdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :spokesman_id, :integer
  end

  def self.down
    remove_column :users, :spokesman_id
  end
end
