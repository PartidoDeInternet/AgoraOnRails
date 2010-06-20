class CreateOpinions < ActiveRecord::Migration
  def self.up
    create_table :opinions do |t|
      t.string :value
      t.integer :organization_id
      t.integer :proposal_id
      t.text :explanation
      t.string :link

      t.timestamps
    end
  end

  def self.down
    drop_table :opinions
  end
end
