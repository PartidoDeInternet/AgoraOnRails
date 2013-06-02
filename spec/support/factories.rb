module Factories
  
  def create_proposal(attrs = {})
    attrs[:title] ||= "Ley Sinde"
    attrs[:proposer] ||= create_proposer
    attrs[:proposed_at]  ||= 2.weeks.ago.to_date
    Proposal.create!(attrs)
  end
  
  def create_vote(attrs = {})
    attrs[:user] ||= create_user
    attrs[:proposal] ||= create_proposal
    Vote.create!(attrs)
  end
  
  def create_user(attrs = {})
    attrs[:provider] ||= "twitter"
    attrs[:uid] ||= "#{rand(9999999)}V"
    attrs[:name] ||= "Mother Fucking Real User"
    User.create!(attrs)
  end
  
  def create_category(attrs = {})
    Category.create!(attrs)
  end
  
  def create_proposer(attrs = {})
    Proposer.create!(attrs)
  end
  
end

RSpec.configuration.include Factories
