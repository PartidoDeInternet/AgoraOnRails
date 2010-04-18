class AddDefault0ToCounters < ActiveRecord::Migration
  def self.up
    change_column :categories, :proposals_count, :integer, :default => 0
    change_column :proposers, :proposals_count, :integer, :default => 0
  end

  def self.down
    
  end
end
