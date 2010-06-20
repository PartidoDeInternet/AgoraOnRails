class AddRepresenterToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :representer_id, :integer
  end

  def self.down
    remove_column :users, :representer_id
  end
end
