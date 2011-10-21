module VotesHelper

  def confirmation_text(value)
    case value
    when "no" then t(:going_to_vote_against)
    when "si" then t(:going_to_vote_in_favor)
    when "abstencion" then  t(:going_to_abstain)
    end
  end

end
