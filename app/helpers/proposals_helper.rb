module ProposalsHelper
  def proposals_heading
    case parent_type
      when :category then "Propuestas relacionadas con #{parent.name}"
      when :proposer then "Propuestas presentadas por #{parent.name}"
      else
        "Propuestas"
    end
  end

  def show_toggle_button(is_admin)
    if (is_admin and !@proposal.closed?)
      button_to("Finalizar votaci&oacute;n", toggle_proposal_path(@proposal)).html_safe
    end
  end

  def show_closed_text
    if @proposal.closer_id.present?
      "El periodo de votaci&oacute;n para esta propuesta finaliz&oacute; el #{l(@proposal.closed_at)}"
    else
      "La Propuesta fue <span class=\"official_resolution\"> #{@proposal.official_resolution}</span> en el Congreso."
    end

  end
end
