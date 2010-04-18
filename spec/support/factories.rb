module Factories
  
  def create_proposal(attrs = {})
    attrs[:title] ||= "Ley Sinde"
    Proposal.create!(attrs)
  end
  
  def create_vote(attrs = {})
    attrs[:user] ||= create_user
    attrs[:proposal] ||= create_proposal
    Vote.create!(attrs)
  end
  
  def create_user(attrs = {})
    attrs[:dni] ||= "99999999#{rand(1000)}Z"
    attrs[:password] ||= "secret"
    attrs[:password_confirmation] ||= "secret"
    attrs[:email] ||= "pepe#{rand(1000)}@gmail.com"
    attrs[:first_name] ||= "José"
    attrs[:last_name] ||= "López"
    User.create!(attrs)
  end
  
  def create_category(attrs = {})
    Category.create!(attrs)
  end
  
  def create_proposer(attrs = {})
    Proposer.create!(attrs)
  end
  
end

Spec::Runner.configuration.include(Factories)