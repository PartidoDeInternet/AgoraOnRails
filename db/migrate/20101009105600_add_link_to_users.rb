class AddLinkToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :link, :string
  end

  def self.down
    remove_column :users, :link
  end
end
