module HelperMethods
  def login_as(user)
    visit login_path
    fill_in "DNI", :with => user.dni
    fill_in "Contraseña", :with => "secret"
    click_button "Identificarse"
  end
  
end

Spec::Runner.configuration.include(HelperMethods)
