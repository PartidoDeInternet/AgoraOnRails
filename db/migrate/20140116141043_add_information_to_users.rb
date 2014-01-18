class AddInformationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :languages, :string
    add_column :users, :education, :string
  end
end
