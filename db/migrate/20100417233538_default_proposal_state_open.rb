class DefaultProposalStateOpen < ActiveRecord::Migration
  def self.up
    change_column :proposals, :closed, :boolean, :default => false
  end

  def self.down
    change_column :proposals, :closed, :boolean, :default => nil
  end
end
