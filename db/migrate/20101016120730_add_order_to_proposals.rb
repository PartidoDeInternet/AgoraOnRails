class AddOrderToProposals < ActiveRecord::Migration
  def self.up
    add_column :proposals, :position, :integer
  end

  def self.down
    remove_column :proposals, :position
  end
end
