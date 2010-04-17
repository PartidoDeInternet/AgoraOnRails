class OfficialResolutionForProposal < ActiveRecord::Migration
  def self.up
    add_column :proposals, :official_resolution, :string
  end

  def self.down
    remove_column :proposals, :official_resolution
  end
end
