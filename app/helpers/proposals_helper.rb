module ProposalsHelper
  
  def proposal_type
    if parent then parent_type
    else action_name end
  end

  def proposal_info(section)
    case proposal_type
      when :category, :proposer
        t "#{section}_#{proposal_type}", proposal_type.to_sym => parent.name
      else
        t "#{section}_#{proposal_type}"
    end
  end

  def proposal_title
    if action_name == "hot" then t(:welcome)
    else proposal_info(:heading) end
  end
  
  def choice_result(proposal, choice)
    content_tag :strong, :style => "width:#{percentage_for(proposal, choice)}; max-width: 310px" do
      content_tag :span do
        humanize(choice)
      end
    end
  end
  
  def percentage_for(proposal, choice)
    number_to_percentage(proposal.percentage_for(choice.to_sym) , :precision => 0)
  end

  def show_toggle_button(is_admin)
    if is_admin && @proposal.open?
      button_to t(:end_voting), toggle_proposal_path(@proposal)
    end
  end

  def show_closed_text
    if @proposal.closed? && @proposal.status.blank?
      t(:closed, :date => l(@proposal.closed_at))
    else
      t(:congress_status_html, :status => @proposal.status)
    end

  end
end
