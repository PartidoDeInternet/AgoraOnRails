module ApplicationHelper

  def import_bootstrap?
    action_name == "new" and ["votes", "spokesmen"].include?(controller_name)
  end
  
  def menu_link(text, url)
    content_tag :li do
      link_to text, url, :class => "navlinks"
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
