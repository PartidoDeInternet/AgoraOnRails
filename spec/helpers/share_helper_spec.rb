require File.dirname(__FILE__) + "/../spec_helper"

describe ShareHelper do
  include ShareHelper
  
  it "should provide an iframe to share with facebook" do
    proposal = create_proposal
    share_on_facebook_link(proposal).should be_include(proposal_url(proposal))
  end
  
  it "should provide an iframe to share with twitter" do
    proposal = create_proposal
    link     = share_on_twitter_link(proposal)
    
    link.should be_include(share_text)    
    link.should be_include(proposal_url(proposal))
  end
end