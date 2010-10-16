require File.dirname(__FILE__) + '/acceptance_helper'

feature "", %q{
  In order to change the mother fucking world
  As a citizen
  I want to vote for/against proposals
} do
  
  background do
    @zapatero  = create_user         :last_name =>  "Zapatero"
    @rajoy     = create_user         :last_name =>  "Rajoy"
    @pepe      = create_user         :first_name => "Pepe", :spokesman => @zapatero
    @ley_sinde = create_proposal     :title =>      "Ley Sinde"
  end
  
  scenario "Citizen doesn't vote but representer votes" do  
    create_vote :proposal => @ley_sinde, :user => @zapatero, :value => "si"
    @ley_sinde.count_delegated_votes! 
    @ley_sinde.total_in_favor.should == 2
  end

  scenario "Spokesman votes but it doens't have represented users" do  
    create_vote :proposal => @ley_sinde, :user => @rajoy, :value => "si"
    @ley_sinde.count_delegated_votes!
    @ley_sinde.total_in_favor.should == 1
  end

  scenario "Citizen doesn't vote and spokesman doesn't vote either" do
    @ley_sinde.count_delegated_votes!
    @ley_sinde.total_in_favor.should == 0
    @ley_sinde.total_against.should == 0
  end
  
  scenario "Citizen votes and spokesman votes something different" do
    create_vote :user => @pepe, :proposal => @ley_sinde, :value => "no"
    create_vote :user => @zapatero, :proposal => @ley_sinde, :value => "si"
    @ley_sinde.count_delegated_votes!
    @ley_sinde.total_in_favor.should == 1
    @ley_sinde.total_against.should == 1
  end
end