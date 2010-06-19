require File.dirname(__FILE__) + '/acceptance_helper'

feature "Feature name", %q{
  In order to ...
  As a ...
  I want to ...
} do
  
  background do
    @user = create_user(:login => "123456789A")
  end
  
  scenario "Create Representive" do
    visit new_representative_path
    
    fill_in "Nombre", :with => "Greenpeace"
    fill_in "Descripción", :with => "Non Profit Organization trying to save the Planet"
    #upload_logo
    click_button "Crear"

    save_and_open_page
    page.should have_content("Representante creado con éxito")
    
    Representative.count.should == 1
    representative = Representative.first
    representative.name.should == "Greenpeace"
    representative.description.should == "Non Profit Organization trying to save the Planet"
  end
  
  scenario "Choose representative" do
    representative = create_representative :name => "Greenpeace"
    login_as @user
    
    visit representative_path(representative)
    click_button "Elegir como representante"
    
    page.should have_content("Has elegido a tu representante.")
    @user.reload
    @user.representative.should == representative
  end
  
  scenario "Don't allow to choose representative unless user is logged in" do
    representative = create_representative :name => "Greenpeace"
    
    visit representative_path(representative)
    page.should_not have_css("#choose_representative_button", :value => "Elegir como representante")
    
  end
    
    
  
end