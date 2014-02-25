module ApplicationHelper

  def home?
    request.original_url == root_url
  end

  def import_bootstrap?
    action_name == "new" and ["votes", "spokesmen"].include?(controller_name)
  end

  def menu_link(text, path, icon='')
    content_tag :li, class: current_page_css(path) do
      link_to path, class: "nav-link" do
        content_tag(:span, '', class: icon) +
        text
      end
    end
  end
  
  def nav_link(resource, path, index)
    content_tag :li, class: current_page_css(path) do
      link_to path, :class => "aside-nav-item name tag-#{index + 1}", :title => resource.name do
        short_name(resource) +
        content_tag(:span, class: "block-list__count") do 
          resource.proposals_count.to_s 
        end
      end
    end
  end
  
  def current_page_css(path)
    current_page?(path) ? 'selected' : ''
  end
  
  def short_name(resource)
    truncate(resource.name, :length => 30)
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
  
  def vote_or_delegation_count
    users_page? ? User.sum(:represented_users_count) : Vote.count
  end
  
  def vote_or_delegation_key
    users_page? ? :delegations_through_agora : :votes_through_agora
  end
end
