class CreateProposals < ActiveRecord::Migration
  def self.up
    create_table :proposals do |t|
      t.string :title
      t.string :official_url
      t.string :proposal_type

      t.timestamps
    end
  end

  def self.down
    drop_table :proposals
  end
end
