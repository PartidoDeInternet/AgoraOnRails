require File.dirname(__FILE__) + '/acceptance_helper'

feature "", %q{
  In order to change the mother fucking world
  As a citizen
  I want to vote for/against proposals
} do
  
  background do
    @zapatero  = create_user         :last_name =>  "Zapatero"
    @psoe      = create_organization :name =>       "PSOE", :spokesman => @zapatero
    @falange   = create_organization :name =>       "Falange"
    @pepe      = create_user         :first_name => "Pepe", :representer => @psoe
    @ley_sinde = create_proposal     :title =>      "Ley Sinde"
    
  end
  
  scenario "Citizen doesn't vote but representer votes" do  
    create_opinion :proposal => @ley_sinde, :organization => @psoe, :value => "si"
    @ley_sinde.count_delegated_votes! 
    @ley_sinde.in_favor.should == 1
  end

  scenario "Organization opines but it doens't have represented users" do  
    create_opinion :proposal => @ley_sinde, :organization => @falange, :value => "si"
    @ley_sinde.count_delegated_votes!
    @ley_sinde.in_favor.should == 0
  end

  
  scenario "Citizen doesn't vote and representer doesn't vote either" do
    @ley_sinde.count_delegated_votes!
    @ley_sinde.in_favor.should == 0
  end
  
  scenario "Citizen votes and representer votes something different" do
    create_vote :user => @pepe, :proposal => @ley_sinde, :value => "no"
    create_opinion :organization => @psoe, :proposal => @ley_sinde, :value => "si"
    @ley_sinde.in_favor.should == 0
    @ley_sinde.against.should == 1
  end
end