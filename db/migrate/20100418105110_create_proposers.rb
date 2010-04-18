class CreateProposers < ActiveRecord::Migration
  def self.up
    create_table :proposers do |t|
      t.string :name
      t.string :full_name
      
      t.timestamps
    end
    add_column :proposals, :proposer_id, :integer
  end

  def self.down
    remove_column :proposals, :proposer_id
    drop_table :proposers
  end
end
