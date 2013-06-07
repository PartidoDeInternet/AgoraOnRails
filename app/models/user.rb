class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :votes
  has_many :voted_proposals, :through => :votes, :source => :proposal
  has_many :voted_open_proposals, -> { where(closed_at: nil) }, :through => :votes, :source => :proposal
  has_many :represented_users, :class_name => "User", :foreign_key => :spokesman_id

  belongs_to :spokesman, :class_name => "User", :counter_cache => :represented_users_count
  
  validates :name,     presence: true
  validates :email,    presence: true
  validates :password, presence: true
  validates :uid,      presence: true, if: :provider 
  validate  :prevent_oneself_as_spokesman
  
  after_save :count_votes
  
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

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.nickname = auth.info.nickname
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]      
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params        
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def email_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

end
