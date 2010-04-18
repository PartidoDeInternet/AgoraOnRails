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
        resolution = proposal_page.search("//*[@class='apartado_iniciativa' and contains(text(),'Resultado de la tramitación')]").first

        proposal = Proposal.find_or_create_by_title(clean_text(title.content))
        proposal.update_attributes! :official_url  => "http://www.congreso.es" + title[:href],
                                    :proposal_type => proposal_type,
                                    :closed        => resolution.present?
        progress.inc
      end
      results_page = results_page.link_with(:text => /Siguiente/).try(:click)
    end
    progress.finish
  end
  
  private
  
  def clean_text(text)
    return unless text
    text.gsub(/\s+/,' ').gsub(/\s*\.\s*$/, '')
  end
  
end