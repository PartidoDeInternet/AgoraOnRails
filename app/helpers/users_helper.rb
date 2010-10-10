module UsersHelper  
  def humanize_vote_text(user, proposal)
    case find_choice user, proposal
    when "si": "A favor"
    when "no": "En contra" 
    when "abstencion": "Abstención"
    end
  end
  
  def css_for_vote(user, proposal)
    case find_choice user, proposal
    when "si": "voted_in_favor"
    when "no": "voted_against" 
    when "abstencion": "voted_abstention"
    end
  end
  
  def find_choice(user, proposal)
    Vote.find_by_user_id_and_proposal_id(user.id, proposal.id).value
  end
end
