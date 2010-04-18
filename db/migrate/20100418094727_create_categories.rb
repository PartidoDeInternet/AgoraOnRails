class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name
      t.string :commission_name

      t.timestamps
    end
    
    add_column :proposals, :category_id, :integer
  end

  def self.down
    remove_column :proposals, :category_id
    drop_table :categories
  end
end
