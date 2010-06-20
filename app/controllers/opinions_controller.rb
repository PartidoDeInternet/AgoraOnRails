class OpinionsController < InheritedResources::Base
    
  def new
    @opinion = Opinion.new(params[:opinion].merge(:value => params[:value]))
  end
  
end
