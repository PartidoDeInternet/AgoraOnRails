module ShareHelper
  def image_url(source)
    abs_path = image_path(source)
    unless abs_path =~ /^http/
      abs_path = "#{request.protocol}#{request.host_with_port}#{abs_path}"
    end
   abs_path
  end

  def share_text(proposal)
    t(:share_text, :url => proposal_url(proposal))
  end

  def share_on_facebook_link(proposal)
    %{<iframe src="http://www.facebook.com/plugins/like.php?href=#{CGI.escape(proposal_url(proposal))}&locale=es_ES&amp;layout=standard&amp;show_faces=true&amp;width=450&amp;action=recommend&amp;font=arial&amp;colorscheme=light&amp;height=80" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:450px; height:80px;" allowTransparency="true" name="fb-share"></iframe>
}.html_safe
  end

  def share_on_twitter_link(proposal)
    %{<iframe allowtransparency="true" frameborder="0" scrolling="no"
        src="http://platform.twitter.com/widgets/tweet_button.html?url=#{CGI.escape(proposal_url(proposal))}&via=#{CGI.escape("pdi: El Partido de Internet")}&text=#{CGI.escape(share_text(proposal))}&lang=es&count=horizontal"
        style="width:130px; height:50px;" name="twitter-share"></iframe>
}.html_safe
  end
end
