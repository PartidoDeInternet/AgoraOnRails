class AddRepresentativeToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :representative_id, :integer
  end

  def self.down
    remove_column :users, :representative_id
  end
end
