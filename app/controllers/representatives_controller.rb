class RepresentativesController < InheritedResources::Base
  
  def create
    @representative = Representative.new(params[:representative])
     if @representative.save
       flash[:notice] = "Representante creado con éxito"
       redirect_to @representative
     else
       render :action => :new
     end
    
  end

end
