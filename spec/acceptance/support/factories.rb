module Factories
  
  def create_proposal(attrs = {})
    attrs[:title] ||= "Ley Sinde"
    Proposal.create!(attrs)
  end
  
  def create_user(attrs = {})
    attrs[:dni] ||= "999999999Z"
    attrs[:password] ||= "secret"
    attrs[:password_confirmation] ||= "secret"
    attrs[:email] ||= "pepe#{rand(1000)}@gmail.com"
    attrs[:first_name] ||= "José"
    attrs[:last_name] ||= "López"
    User.create!(attrs)
  end
  
end

Spec::Runner.configuration.include(Factories)