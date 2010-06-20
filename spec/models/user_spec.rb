require File.dirname(__FILE__) + "/../spec_helper"

describe User do
  it "could have a representer" do
    organization = create_organization(:name => "Greenpeace")
    user = create_user(:representer => organization)
    user.representer.should == organization
    organization.represented_users.should include(user)
  end
  
  it "could represent an organization" do
    zp = create_user(:first_name => "Jose Luis", :last_name => "Zapatero")
    psoe = create_organization(:name => "PSOE", :spokesman => zp)
    zp.represented_organization.should == psoe
  end
end