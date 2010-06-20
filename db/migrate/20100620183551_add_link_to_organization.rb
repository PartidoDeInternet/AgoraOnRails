class AddLinkToOrganization < ActiveRecord::Migration
  def self.up
    add_column :organizations, :link, :string
  end

  def self.down
    remove_column :organizations, :link
  end
end
