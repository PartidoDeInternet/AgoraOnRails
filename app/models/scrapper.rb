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
    ENV['CONGRESS_API_URL'] || "http://congress-api.herokuapp.com"
  end

  def update_or_create_proposal(attributes)
    proposal = Proposal.find_or_create_by_title(attributes["title"])

    category_name     = attributes.delete("category_name")     
    proposal.category = Category.find_or_create_by_commission_name(category_name) 
    
    proposer_name     = attributes.delete("proposer_name")
    proposal.proposer = Proposer.find_or_create_by_full_name(proposer_name)

    proposal.update_attributes!(attributes)
  end

end