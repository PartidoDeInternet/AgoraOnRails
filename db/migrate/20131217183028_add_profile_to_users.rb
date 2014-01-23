class AddProfileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :resume, :string
    add_column :users, :profile_picture, :string
    add_column :users, :twitter_user, :string
    add_column :users, :website_link, :string
    add_column :users, :other_link, :string
  end
end
