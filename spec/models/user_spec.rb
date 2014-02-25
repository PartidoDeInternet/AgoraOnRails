require File.dirname(__FILE__) + "/../spec_helper"

describe User do
  it "could have a spokesman" do
    buenafuente = create_user(:name => "Buenafuente")
    user = create_user(:spokesman => buenafuente)
    user.spokesman.should == buenafuente
    buenafuente.represented_users.should include(user)
  end

  it "does not allow a user to choose himself as a spokesman" do
    expect{
      buenafuente = create_user(:name => "Buenafuente")
      buenafuente.update_attributes!(:spokesman => buenafuente)
    }.to raise_error
  end

end