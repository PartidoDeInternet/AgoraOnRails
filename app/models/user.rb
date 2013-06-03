class User < ActiveRecord::Base
  has_many :votes
  has_many :voted_proposals, :through => :votes, :source => :proposal
  has_many :voted_open_proposals, -> { where(closed_at: nil) }, :through => :votes, :source => :proposal
  belongs_to :spokesman, :class_name => "User", :counter_cache => :represented_users_count
  has_many :represented_users, :class_name => "User", :foreign_key => :spokesman_id
  validate :prevent_oneself_as_spokesman
  
  after_save :count_votes
  
  validates :provider, :presence => true
  validates :uid, :presence => true
  
  def has_voted_for?(proposal)
    voted_proposals.include?(proposal)
  end
    
  def delegated_vote_for(proposal)
    return nil if has_voted_for?(proposal) or spokesman.nil? 
    
    spokesman.vote_for(proposal)
  end
  
  def vote_for(proposal)
    delegation_chain.each do |member|
      if vote = member.find_vote(proposal) 
        return vote 
      end
    end
    nil
  end
  
  def find_vote(proposal)
    return votes.find_by_proposal_id(proposal)
  end
  
  def delegation_chain
    list = []
    current = self
    while current.present? && !list.include?(current)
      list << current
      current = current.spokesman
    end
    list
  end
  
  def voted_and_delegated_proposals
    delegation_chain.map(&:voted_proposals).flatten
  end
  
  def voted_and_delegated_open_proposals
    delegation_chain.map(&:voted_open_proposals).flatten
  end
  
  def count_votes
    if spokesman_id_changed?
      changed_spokesmen = [spokesman, User.find_by_id(spokesman_id_was)].compact
      proposals_to_update = changed_spokesmen.map(&:voted_and_delegated_open_proposals).flatten.uniq
      proposals_to_update.map(&:count_votes!)
    end
  end

  def prevent_oneself_as_spokesman
    errors.add :spokesman_id, "No puedes ser tu propio portavoz." if spokesman == self 
  end

  def is_admin?
    admin
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      #refactor
      user.name = user.provider == "twitter" ? auth["user_info"]["name"] : auth["info"]["name"]
    end
  end

end
