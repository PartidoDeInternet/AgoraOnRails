class Scrapper

  def initialize 
  end

  def scrape
    proposals.each do |attributes|
      update_or_create_proposal(attributes)
    end
  end

  def proposals
    api.get("proposals.json").body
  end

  def api  
    Faraday.new api_host do |conn|
      conn.use     FaradayMiddleware::ParseJson
      conn.use     FaradayMiddleware::Mashify
      conn.adapter Faraday.default_adapter
    end
  end

  def api_host
    "http://congress-api.herokuapp.com"
  end

  def update_or_create_proposal(attributes)
    proposal = Proposal.find_or_create_by(title: attributes["title"])

    category_name     = attributes.delete("category_name")     
    proposal.category = Category.find_or_create_by(commission_name: category_name) 
    
    proposer_name     = attributes.delete("proposer_name")
    proposal.proposer = Proposer.find_or_create_by(full_name: proposer_name)

    attributes[:api_id] = attributes.delete("id")
    proposal.update_attributes!(attributes)
  end

end