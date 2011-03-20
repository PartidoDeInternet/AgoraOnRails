# -*- coding: utf-8 -*-
module VotesHelper

  def confirmation_text(value)
    case value
    when "no" then "a votar en contra de"
    when "si" then "a votar a favor de"
    when "abstencion" then  "a abstenerte de votar sobre"
    end
  end

end
