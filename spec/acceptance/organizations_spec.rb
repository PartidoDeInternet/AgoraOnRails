require File.dirname(__FILE__) + '/acceptance_helper'

feature "Feature name", %q{
  In order to ...
  As a ...
  I want to ...
} do
  
  background do
    @user = create_user(:login => "123456789A")
  end
  
  scenario "View Organizations" do
    zapatero = create_user :first_name => "Jose Luis", :last_name => "Zapatero"
    create_organization :name => "PSOE", :description => "Partido Socialista", :link => "http://www.psoe.es", :spokesman => zapatero
    rajoy = create_user :first_name => "Mariano", :last_name => "Rajoy"
    create_organization :name => "PP", :description => "Partido Popular", :link => "http://www.pp.es", :spokesman => rajoy
    
    visit "/"
    click_link "Organizaciones"
    
    page.should have_css(".organization .name", "PSOE")
    page.should have_css(".organization .description", "Partido Socialista")
    page.should have_css(".organization .link", "http://www.psoe.es")
    page.should have_css(".organization .spokesman .name", "Jose Luis Zapatero")
    
    page.should have_css(".organization .name", "PP")
    page.should have_css(".organization .description", "Partido Popular")
    page.should have_css(".organization .link", "http://www.pp.es")
    page.should have_css(".organization .spokesman .name", "Mariano Rajoy")
  end
  
  scenario "Can't create organization unless logged in" do
    visit new_organization_path
    page.should have_content("Autenticación requerida")
  end
  
  scenario "Create Organization" do
    login_as @user
    
    visit organizations_path
    click_link "Quiero dar de alta a otra organizacion en Populo"
    
    fill_in "Nombre", :with => "Greenpeace"
    fill_in "Descripción", :with => "Non Profit Organization trying to save the Planet"
    #upload_logo
    click_button "Crear"

    page.should have_content("Organización creada con éxito")
    
    Organization.count.should == 1
    organization = Organization.first
    organization.name.should == "Greenpeace"
    organization.description.should == "Non Profit Organization trying to save the Planet"
    organization.spokesman.should == @user
  end
  
  scenario "Choose organization" do
    organization = create_organization :name => "Greenpeace"
    login_as @user
    
    visit organization_path(organization)
    click_button "Elegir como organización representante"
    
    page.should have_content("Has elegido a tu representante.")
    @user.reload
    @user.representer.should == organization
  end
  
  scenario "Don't allow to choose organization unless user is logged in" do
    organization = create_organization :name => "Greenpeace"
    
    visit organization_path(organization)
    page.should_not have_css("#choose_organization_button", :value => "Elegir como representante")
  end
    
end