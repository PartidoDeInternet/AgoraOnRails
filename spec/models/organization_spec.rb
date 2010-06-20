require File.dirname(__FILE__) + "/../spec_helper"

describe Organization do
  it "should have a spokesman" do
    spokesman = create_user
    organization = create_organization(:spokesman => spokesman)
    
    organization.spokesman.should == spokesman
  end
  
  it "could have many represented users" do
    greenpeace = create_organization
    users = ["Paco", "Pepe", "Pedro"].collect do |name|
      create_user :first_name => name, :representer => greenpeace
    end
    
    users.each do |user|
      greenpeace.represented_users.should include(user)
    end
  end
end