module ApplicationHelper

  def home?
    request.original_url == root_url
  end

  def import_bootstrap?
    action_name == "new" and ["votes", "spokesmen"].include?(controller_name)
  end
  
  def menu_link(text, url, icon='')
    content_tag :li do
      link_to url, :class => "nav-link" do
        "<span class='#{icon}'></span>#{text}".html_safe
      end
    end
  end
  
  def nav_link(resource, path, index)
    class_name = current_page?(path) ? 'selected' : ''

    content_tag(:li, :class => class_name) do
      link_to(truncate(resource.name, :length => 30), path, 
        :class => "name tag-#{index + 1} #{class_name}", 
        :title => resource.name) +
      
      content_tag(:span, :class => "block-list__count") do
        resource.proposals_count.to_s
      end

    end
  end

  def hot_categories
    @hot_categories ||= Category.hot
  end
  
  def hot_proposers
    @proposers ||= Proposer.hot
  end
  
  # Awesome truncate
  # First regex truncates to the length, plus the rest of that word, if any.
  # Second regex removes any trailing whitespace or punctuation (except ;).
  # Unlike the regular truncate method, this avoids the problem with cutting
  # in the middle of an entity ex.: truncate("this &amp; that",9)  => "this &am..."
  # though it will not be the exact length.
  def awesome_truncate(text, length = 30, truncate_string = "...")
    return if text.nil?
    l = length - truncate_string.mb_chars.length
    text.mb_chars.length > length ? text[/\A.{#{l}}\w*\;?/m][/.*[\w\;]/m] + truncate_string : text
  end
  
  def humanize(choice)
    t(choice)
  end
  
  def who_did_vote(proposal)
    if proposal.votes.blank?
       t(:be_first)
    else
      pluralize(proposal.votes.count, t(:one_did_it), t(:many_did_it))
    end
  end
end
