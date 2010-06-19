class OrganizationsController < InheritedResources::Base
  
  def create
    @organization = Organization.new(params[:organization])
     if @organization.save
       flash[:notice] = "Organización creada con éxito"
       redirect_to @organization
     else
       render :action => :new
     end
    
  end

end
