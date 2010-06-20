class AddSpokesmanToOrganization < ActiveRecord::Migration
  def self.up
    add_column :organizations, :spokesman_id, :integer
  end

  def self.down
    remove_column :organizations, :spokesman_id
  end
end
