# coding: utf-8
module ApplicationHelper
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
    case choice
    when "in_favor" then "Sí"
    when "against" then "No"
    when "abstention" then "Abs"
    end
  end
  
  def vote_text(proposal)
    if proposal.votes.blank?
      "<strong>Vota!</strong> Sé el primero en votar".html_safe
    else
      "<strong>Vota!</strong> #{pluralize(proposal.votes.count, 'persona ya lo ha hecho', 'personas ya lo han hecho')}".html_safe
    end
  end
end
