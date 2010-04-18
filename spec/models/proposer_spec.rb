require 'spec_helper'

describe Proposer do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :full_name => "value for full_name"
    }
  end

  it "should create a new instance given valid attributes" do
    Proposer.create!(@valid_attributes)
  end
end
