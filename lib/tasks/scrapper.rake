namespace :scrapper do
  desc "Update data from congreso.es"
  task :scrape => :environment do
    Congress::Scrapper.scrape.each do |proposal_attrs|
      proposal          = Proposal.find_or_create_by_title(proposal_attrs[:title])
      
      comission_name    = proposal_attrs.delete(:commission_name)
      proposal.category = Category.find_or_create_by_commission_name(comission_name)      
      
      full_name         = proposal_attrs.delete(:proposer)
      proposal.proposer = Proposer.find_or_create_by_full_name(full_name)
      
      proposal.update_attributes!(proposal_attrs)
    end
  end
end