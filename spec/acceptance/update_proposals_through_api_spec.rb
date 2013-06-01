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
    VCR.use_cassette('congress-api', :re_record_interval => 1.day) do
      Scrapper.new.scrape
    end
    Proposal.count.should be > 1
    proposal = Proposal.last
    proposal.title.should         == "Proyecto de Ley de medidas urgentes para la reforma del mercado laboral (procedente del Real Decreto-Ley 3/2012, de 10 de febrero)"
    proposal.official_url.should  == "http://www.congreso.es/portal/page/portal/Congreso/Congreso/Iniciativas/Busqueda%20Avanzada?_piref73_1335465_73_1335464_1335464.next_page=/wc/servidorCGI&CMD=VERLST&BASE=IW10&PIECE=IWA0&FMT=INITXD1S.fmt&FORM1=INITXLTS.fmt&DOCS=22-22&QUERY=%28I%29.ACIN1.+%26+%28%22COMPETENCIA+LEGISLATIVA+PLENA%22%29.TPTR."
    proposal.proposal_type.should == "Proyecto de ley"
    proposal.status.should        == "Aprobado con modificaciones"
    proposal.category.name        == "Empleo y Seguridad Social"
    proposal.proposer.name        == "Gobierno"
    proposal.proposed_at          == "08 de marzo de 2012"
    proposal.closed_at            == "28 de junio de 2012"
    proposal.body                 =~ /En cumplimiento de lo dispuesto en el artículo 86.2 de la Constitución, el Real Decreto-ley 3\/2012, de 10 de febrero, de medidas urgentes para la reforma del mercado laboral/
  end
end