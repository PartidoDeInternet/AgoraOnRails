class OrganizationsController < InheritedResources::Base
  
  before_filter :require_user, :except => [:show, :index]
  
  def create
    @organization = Organization.new(params[:organization])
    @organization.spokesman = current_user
     if @organization.save
       flash[:notice] = "Organización creada con éxito"
       redirect_to @organization
     else
       render :action => :new
     end
    
  end

end
