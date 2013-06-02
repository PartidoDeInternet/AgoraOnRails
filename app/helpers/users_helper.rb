# coding: utf-8
module UsersHelper  
  def humanize_vote_text(user, proposal)
    case find_choice user, proposal
    when "si" then "A favor"
    when "no" then "En contra" 
    when "abstencion" then "Abstención"
    end
  end
  
  def css_for_vote(user, proposal)
    case find_choice user, proposal
    when "si" then "voted_in_favor"
    when "no" then "voted_against" 
    when "abstencion" then "voted_abstention"
    end
  end
  
  def find_choice(user, proposal)
    find_vote(user, proposal).value
  end

  def find_vote(user, proposal)
    Vote.find_by_user_id_and_proposal_id(user.id, proposal.id)    
  end
end
