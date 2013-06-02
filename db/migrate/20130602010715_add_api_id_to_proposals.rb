class AddApiIdToProposals < ActiveRecord::Migration
  def change
    add_column :proposals, :api_id, :integer
  end
end
