class AddProposalsCountToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :proposals_count, :integer
  end

  def self.down
    remove_column :categories, :proposals_count
  end
end
