# coding: utf-8
require File.dirname(__FILE__) + '/acceptance_helper'

feature "", %q{
  In order to have up-to-date proposals
  As an admin
  I want to update the proposals through congress-api
} do

  background do
    VCR.configure do |c|
      c.cassette_library_dir = 'fixtures/vcr_cassettes'
      c.hook_into :webmock
    end
  end
  
  scenario "update proposals through the congress-api" do
    VCR.use_cassette('congress-api', :re_record_interval => 1.week) do
      Scrapper.new.scrape
    end
    Proposal.count.should be > 1    
    proposal = Proposal.where(:api_id => 1).first
    proposal.title.should         == "Proyecto de Ley de medidas urgentes para reforzar la protección a los deudores hipotecarios (procedente del Real Decreto-Ley 27/2012, de 15 de noviembre)"
    proposal.official_url.should  ==  "http://www.congreso.es/portal/page/portal/Congreso/Congreso/Iniciativas/Busqueda%20Avanzada?_piref73_1335465_73_1335464_1335464.next_page=/wc/servidorCGI&CMD=VERLST&BASE=IW10&PIECE=IWA0&FMT=INITXD1S.fmt&FORM1=INITXLTS.fmt&DOCS=28-28&QUERY=%28I%29.ACIN1.+%26+%28%22COMPETENCIA+LEGISLATIVA+PLENA%22%29.TPTR."
    proposal.proposal_type.should == "Proyecto de ley"
    proposal.status.should        == "Subsumido en otra iniciativa"
    proposal.category.name        == "Economía y Competitividad"
    proposal.proposer.name        == "Gobierno"
    proposal.proposed_at          == "29 de noviembre de 2012"
    proposal.closed_at            == "No disponible"
    proposal.body                 =~ /En cumplimiento de lo dispuesto en el artículo 86.2 de la Constitución, el Real Decreto-ley 27\/2012, de 15 de noviembre, de medidas urgentes para reforzar la protección a los deudores hipotecarios/
    proposal.api_id               == "1"
  end
end