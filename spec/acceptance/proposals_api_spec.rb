require File.dirname(__FILE__) + '/acceptance_helper'

feature "Proposals API", %q{
  In order to create other cool apps
  As a developer
  I want to have an xml representation of... stuff
} do
  
  scenario "XML Representation of a single proposal" do
    
    proposer = create_proposer(:name => "Greenpeace")
    category = create_category(:name => "Education")
    proposal = create_proposal(:title => "The proposal",
                     :in_favor      => 5,
                     :against       => 10,
                     :abstention    => 1,
                     :proposal_type => "National",
                     :official_url  => "http://thecongress.com/the_proposal",
                     :official_resolution => "Rejected",
                     :proposer => proposer,
                     :category => category)

    visit "/proposals/#{proposal.to_param}.xml"
    
    
    proposal_hash = Hash.from_xml(page.body)['proposal']
    
    proposal_hash['title'].should == 'The proposal'
    proposal_hash['id'].should be_blank
    proposal_hash['updated_at]'].should be_blank
    proposal_hash['created_at'].should be_blank
    proposal_hash['position'].should be_blank
    
    proposal_hash['in_favor'].should == 5
    proposal_hash['against'].should == 10
    proposal_hash['abstention'].should == 1
    proposal_hash['category_id'].should == category.id
    proposal_hash['category_name'].should == "Education"
    proposal_hash['proposal_type'].should == "National"
    proposal_hash['official_url'].should == "http://thecongress.com/the_proposal"
    proposal_hash['proposer_id'].should == proposer.id
    proposal_hash['proposer_name'].should == "Greenpeace"
    proposal_hash['official_resolution'].should == "Rejected"
  end
  
end
