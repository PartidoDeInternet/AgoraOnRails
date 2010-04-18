class Proposal < ActiveRecord::Base
  has_many :votes
  
  named_scope :open, :conditions => "not closed"
  named_scope :hot,  :order => "ranking DESC", :limit => 5
  
  #choices can be in_favor, against or abstention
  def percentage_for(choice)
    vote_choice = self.send(choice)
    vote_choice > 0 ? (vote_choice.to_f / votes.count * 100) : 0  
  end
    
end
