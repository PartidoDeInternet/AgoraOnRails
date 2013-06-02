class RemovePositionFromProposals < ActiveRecord::Migration
  def change
    remove_column :proposals, :position
  end
end
