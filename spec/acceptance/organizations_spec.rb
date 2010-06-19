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
    visit new_organization_path
    
    fill_in "Nombre", :with => "Greenpeace"
    fill_in "Descripción", :with => "Non Profit Organization trying to save the Planet"
    #upload_logo
    click_button "Crear"

    page.should have_content("Organización creada con éxito")
    
    Organization.count.should == 1
    organization = Organization.first
    organization.name.should == "Greenpeace"
    organization.description.should == "Non Profit Organization trying to save the Planet"
  end
  
  scenario "Choose organization" do
    organization = create_organization :name => "Greenpeace"
    login_as @user
    
    visit organization_path(organization)
    click_button "Elegir como organización representante"
    
    page.should have_content("Has elegido a tu representante.")
    @user.reload
    @user.organization.should == organization
  end
  
  scenario "Don't allow to choose organization unless user is logged in" do
    organization = create_organization :name => "Greenpeace"
    
    visit organization_path(organization)
    page.should_not have_css("#choose_organization_button", :value => "Elegir como representante")
    
  end
    
    
  
end