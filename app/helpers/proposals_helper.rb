module ProposalsHelper
  def proposals_heading
    case parent_type
    when :category: "Propuestas relacionadas con #{parent.name}"
    when :proposer: "Propuestas presentadas por #{parent.name}"
    else
      "Propuestas"
    end
  end
end
