class RemovingLinkFromVotes < ActiveRecord::Migration
  def change
    Vote.all.each do |vote|
      if vote.link.present?
        vote.explanation += " #{vote.link}"
        vote.save!  
      end      
    end
    remove_column :votes, :link
  end
end
