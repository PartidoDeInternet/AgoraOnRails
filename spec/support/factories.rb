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
    attrs[:login] ||= "99999999#{rand(1000)}Z"
    attrs[:password] ||= "secret"
    attrs[:password_confirmation] ||= "secret"
    attrs[:email] ||= "pepe#{rand(1000)}@gmail.com"
    User.create!(attrs)
  end
  
  def create_category(attrs = {})
    Category.create!(attrs)
  end
  
  def create_proposer(attrs = {})
    Proposer.create!(attrs)
  end
  
  def create_organization(attrs = {})
    attrs[:name] ||= "Factory Greenpeace"
    attrs[:description] ||= "Factory an ONG"
    attrs[:spokesman] ||= create_user(:first_name => "Factory spokesman")
    Organization.create!(attrs)
  end
  
  def create_opinion(attrs = {})
    attrs[:organization] ||= create_organization
    attrs[:proposal] ||= create_proposal
    attrs[:value] ||= "si"
    attrs[:explanation] ||= "¿Y por qué no?"
    Opinion.create!(attrs)
  end
  
end

Spec::Runner.configuration.include(Factories)