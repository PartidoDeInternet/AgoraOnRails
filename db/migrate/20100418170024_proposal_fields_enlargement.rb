class ProposalFieldsEnlargement < ActiveRecord::Migration
  def self.up
    change_column :proposals, :title, :string, :limit => 1024
    change_column :proposals, :official_url, :string, :limit => 1024
  end

  def self.down
  end
end
