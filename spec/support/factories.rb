module Factories
  
  def create_proposal(attrs = {})
    attrs[:title]        ||= "Ley Sinde"
    attrs[:proposer]     ||= create_proposer
    attrs[:category]     ||= create_category
    attrs[:proposed_at]  ||= 2.weeks.ago.to_date
    Proposal.create!(attrs)
  end
  
  def create_vote(attrs = {})
    attrs[:user]     ||= create_user
    attrs[:proposal] ||= create_proposal
    Vote.create!(attrs)
  end
  
  def create_user(attrs = {})
    attrs[:name]     ||= "Mother Fucking Real User"
    attrs[:email]    ||= "user#{rand(999999)}@example.com"
    attrs[:password] ||= "secret"
    User.create!(attrs)
  end
  
  def create_category(attrs = {})
    attrs[:name]     ||= "Justice"
    Category.create!(attrs)
  end
  
  def create_proposer(attrs = {})
    attrs[:name]     ||= "Government"
    Proposer.create!(attrs)
  end
  
end

RSpec.configuration.include Factories
