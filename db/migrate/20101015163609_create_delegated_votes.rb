class CreateDelegatedVotes < ActiveRecord::Migration
  def self.up
    create_table :delegated_votes do |t|
      t.integer :proposal_id
      t.integer :in_favor, :default => 0
      t.integer :against, :default => 0
      t.integer :abstention, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :delegated_votes
  end
end
