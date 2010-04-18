# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def hot_categories
    @hot_categories ||= Category.hot
  end
  
  def hot_proposers
    @proposers ||= Proposer.hot
  end
  
end
