# -*- coding: utf-8 -*-
module VotesHelper

  def confirmation_text(value)
    case value
    when "no" then "a votar en contra de"
    when "si" then "a votar a favor de"
    when "abstencion" then  "a abstenerte de votar sobre"
    end
  end

  def share_text(proposal)
    "He votado a través del partido del internet la propuesta #{proposal_url(proposal)}"
  end

  def share_on_facebook_link(proposal)
    content_tag(:a, "Compartir en Facebook", :class => "share_facebook", :name => "fb_share",
                :href => "http://www.facebook.com/sharer.php?u=#{CGI.escape(proposal_url(proposal))}&t=#{CGI.escape(share_text(proposal))}",
                :target => "_blank")
  end

  def share_on_twitter_link(proposal)
    title = "Compartir en Twitter"
    content_tag(:a, title, :id => "share_twitter",
                :href => "http://twitter.com/home?status=#{share_text(proposal)}",
                :data => proposal_url(proposal),
                :title => title,
                :target => "_blank")
  end

end
