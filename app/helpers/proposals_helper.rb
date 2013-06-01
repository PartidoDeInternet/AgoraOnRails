module ProposalsHelper
  def proposals_heading
    case parent_type
      when :category then t(:related_with_category, :category => parent.name)
      when :proposer then t(:proposed_by_html, :proposer => parent.name)
      else
        t :proposals
    end
  end
  
  def choice_result(proposal, choice)
    content_tag :strong, :style => "width:#{percentage_for(proposal, choice)}-width" do
      content_tag :span do
        humanize(choice)
      end
    end
  end
  
  def percentage_for(proposal, choice)
    number_to_percentage(proposal.percentage_for(choice.to_sym), :precision => 0)
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
