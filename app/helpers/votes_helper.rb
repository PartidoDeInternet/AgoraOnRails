module VotesHelper

  def confirmation_text(value)
    case value
    when "no": "a votar en contra de"
    when "si": "a votar a favor de"
    when "abstencion":  "a abstenerte de votar sobre"
    end
  end
end
