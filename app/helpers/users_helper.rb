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
    when "si" then "favor"
    when "no" then "against" 
    when "abstencion" then "abstention"
    end
  end

  def icon_for_vote(user, proposal)
    case find_choice user, proposal
    when "si" then "thumbs-up"
    when "no" then "thumbs-down" 
    when "abstencion" then ""
    end
  end
  
  def find_choice(user, proposal)
    find_vote(user, proposal).value
  end

  def find_vote(user, proposal)
    Vote.find_by_user_id_and_proposal_id(user.id, proposal.id)    
  end
end
