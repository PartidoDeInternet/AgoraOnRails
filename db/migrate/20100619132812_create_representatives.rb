class CreateRepresentatives < ActiveRecord::Migration
  def self.up
    create_table :representatives do |t|
      t.string :name
      t.text :description
      t.timestamps
    end
  end
  
  def self.down
    drop_table :representatives
  end
end
