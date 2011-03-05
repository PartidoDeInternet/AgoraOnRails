module ProposalsHelper
  def proposals_heading
    case parent_type
    when :category then "Propuestas relacionadas con #{parent.name}"
    when :proposer then "Propuestas presentadas por #{parent.name}"
    else
      "Propuestas"
    end
  end
end
