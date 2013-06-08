json.(@user, :id, :name)
json.children @user.represented_users_tree

