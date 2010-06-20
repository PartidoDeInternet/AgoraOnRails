require File.dirname(__FILE__) + '/acceptance_helper'

feature "Organization Vote", %q{
  In order to change the mother fucking world
  As a citizen
  I want to vote for/against proposals
} do
  
 #acordarse de votar desde el index  
 scenario "A organization votes" do 
   proposal = create_proposal :title => "Ley Sinde"
   zapatero = create_user :first_name => "Jose Luis", :last_name => "Zapatero", :email => "zp@psoe.es"
   psoe = create_organization :name => "PSOE", :spokesman => zapatero
   login_as zapatero

   [["no",         "a votar en contra de",        "representant_vote_no"], 
    ["si",         "a votar a favor de",          "representant_vote_yes"], 
    ["abstencion", "a abstenerte de votar sobre", "representant_vote_abstention"]].each do |vote, confirmation, button_id|
   
     visit proposal_url(proposal)
     page.should have_content("Vota como representante de PSOE")
     
     fill_in "Explica tu opinión", :with => "La ley Sinde es maravillosa"
     fill_in "Enlace", :with => "http://www.sgae.es"
     
     click_button button_id
     page.should have_content("Vas #{confirmation} la iniciativa “Ley Sinde”")
     
     save_and_open_page
     click_button "Estoy seguro"
     page.should have_content("Tu voto en nombre de PSOE ha sido contabilizado.")

     opinion = Opinion.last
     opinion.value.should == vote
     opinion.explanation.should == "La ley Sinde es maravillosa"
     opinion.link.should == "http://www.sgae.es"
   end
 end
 
end