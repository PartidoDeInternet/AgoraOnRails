class ProposalAttributes < ActiveRecord::Migration
  def change
    add_column :proposals, :body, :text
    rename_column :proposals, :official_resolution, :status
  end
end
