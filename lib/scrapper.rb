class Scrapper
  
  def self.scrape
    new.scrape
  end
  
  def agent
    @agent ||= Mechanize.new
  end
  
  def scrape
    search_page = agent.get("http://www.congreso.es/portal/page/portal/Congreso/Congreso/Iniciativas/Busqueda%20Avanzada")
    search_form = search_page.form_with(:action => /enviarCgiBuscadorAvIniciativas/)
    search_form["TPTR"] = "Competencia Legislativa Plena"
    results_page = search_form.submit
    
    total_results = results_page.search("//*[contains(text(), 'Iniciativas encontradas')]/span").first.text.to_i
    progress = ProgressBar.new("Scrapping", total_results)
    
    while results_page
      results_page.search(".titulo_iniciativa a").each do |title|
        proposal_page = agent.get(title[:href])
        
        proposal_type = clean_text(proposal_page.search(".subtitulo_competencias").first.try(:content))
        resolution = clean_text(proposal_page.search("//*[@class='apartado_iniciativa' and contains(normalize-space(text()),'Resultado de la tramitación')]/following-sibling::*[@class='texto']").first.try(:content))
        
        commission_name = clean_text(proposal_page.search("//*[@class='apartado_iniciativa' and contains(normalize-space(text()),'Comisión competente:')]/following-sibling::*[@class='texto']").first.try(:content))
        category = Category.find_or_create_by_commission_name(commission_name)
        
        full_name = clean_text(proposal_page.search("//*[@class='apartado_iniciativa' and contains(normalize-space(text()),'Autor:')]/following-sibling::*[@class='texto']").first.try(:content))
        proposer = Proposer.find_or_create_by_full_name(full_name)
          
        proposed_at_text = proposal_page.search("//*[@class='texto' and contains(normalize-space(text()),'Presentado el')]").first.try(:content)
        proposed_at = Date.new($3.to_i, $2.to_i, $1.to_i) if proposed_at_text && proposed_at_text.match(/Presentado\s+el\s+(\d\d)\/(\d\d)\/(\d\d\d\d)/)
        
        closed_at_text = proposal_page.search("//*[@class='apartado_iniciativa' and contains(normalize-space(text()),'Tramitación seguida por la iniciativa:')]/following-sibling::*[@class='texto']").first.try(:content)
        closed_at = Date.new($3.to_i, $2.to_i, $1.to_i) if closed_at_text && closed_at_text.match(/Concluido\s+.+\s+desde (\d\d)\/(\d\d)\/(\d\d\d\d)/)
        
        proposal = Proposal.find_or_create_by_title(clean_text(title.content))
        proposal.update_attributes! :official_url        => "http://www.congreso.es" + title[:href],
                                    :proposal_type       => proposal_type,
                                    :closed_at           => closed_at,
                                    :official_resolution => resolution,
                                    :category            => category,
                                    :proposer            => proposer,
                                    :proposed_at         => proposed_at
        progress.inc
      end
      results_page = results_page.link_with(:text => /Siguiente/).try(:click)
    end
    progress.finish
  end
  
  private
  
  def clean_text(text)
    return unless text
    text.gsub(/\s+/,' ').gsub(/\s*\.\s*$/, '').strip
  end
  
end