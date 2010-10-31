require File.dirname(__FILE__) + "/../spec_helper"

module CongressWebSitePaths
  def search_page
    "http://www.congreso.es/portal/page/portal/Congreso/Congreso/Iniciativas/Busqueda%20Avanzada"
  end
  
  def search_results_page
    "http://www.congreso.es/portal/page/portal/Congreso/Congreso/Iniciativas/Busqueda%20Avanzada?_piref73_1335465_73_1335464_1335464.next_page=/wc/enviarCgiBuscadorAvIniciativas"
  end
  
  def search_results_next_page
    "http://www.congreso.es/portal/page/portal/Congreso/Congreso/Iniciativas/Busqueda%20Avanzada?_piref73_1335465_73_1335464_1335464.next_page=/wc/servidorCGI&CMD=VERLST&BASE=IWI9&FMT=INITXLTS.fmt&DOCS=26-50&DOCORDER=FIFO&OPDEF=Y&QUERY=%40FECH%26gt%3B%3D20091101+%26+%40FECH%26lt%3B%3D20100417+%26+%28I%29.ACIN1.+%26+%28%22COMPETENCIA+LEGISLATIVA+PLENA%22%29.TPTR."
  end
  
  def proposal_page1
    "http://www.congreso.es/portal/page/portal/Congreso/Congreso/Iniciativas/Busqueda%20Avanzada?_piref73_1335465_73_1335464_1335464.next_page=/wc/servidorCGI&CMD=VERLST&BASE=IWI9&PIECE=IWA9&FMT=INITXD1S.fmt&FORM1=INITXLTS.fmt&DOCS=1-1&QUERY=%40FECH%26gt%3B%3D20091101+%26+%40FECH%26lt%3B%3D20100417+%26+%28I%29.ACIN1.+%26+%28%22COMPETENCIA+LEGISLATIVA+PLENA%22%29.TPTR."
  end
  
  def proposal_page2
    "http://www.congreso.es/portal/page/portal/Congreso/Congreso/Iniciativas/Busqueda%20Avanzada?_piref73_1335465_73_1335464_1335464.next_page=/wc/servidorCGI&CMD=VERLST&BASE=IWI9&PIECE=IWA9&FMT=INITXD1S.fmt&FORM1=INITXLTS.fmt&DOCS=2-2&QUERY=%40FECH%26gt%3B%3D20091101+%26+%40FECH%26lt%3B%3D20100417+%26+%28I%29.ACIN1.+%26+%28%22COMPETENCIA+LEGISLATIVA+PLENA%22%29.TPTR."
  end
  
  def proposal_page3
    "http://www.congreso.es/portal/page/portal/Congreso/Congreso/Iniciativas/Busqueda%20Avanzada?_piref73_1335465_73_1335464_1335464.next_page=/wc/servidorCGI&CMD=VERLST&BASE=IWI9&PIECE=IWA9&FMT=INITXD1S.fmt&FORM1=INITXLTS.fmt&DOCS=26-26&QUERY=%40FECH%26gt%3B%3D20091101+%26+%40FECH%26lt%3B%3D20100417+%26+%28I%29.ACIN1.+%26+%28%22COMPETENCIA+LEGISLATIVA+PLENA%22%29.TPTR."
  end
  
  def proposal_page4
    "http://www.congreso.es/portal/page/portal/Congreso/Congreso/Iniciativas/Busqueda%20Avanzada?_piref73_1335465_73_1335464_1335464.next_page=/wc/servidorCGI&CMD=VERLST&BASE=IWI9&PIECE=IWA9&FMT=INITXD1S.fmt&FORM1=INITXLTS.fmt&DOCS=2-2&QUERY=%28I%29.ACIN1.+%26+%28%22COMPETENCIA+LEGISLATIVA+PLENA%22%29.TPTR.+%26+%28%22APROBADO+SIN+MODIFICACIONES%22%29.CIER."
  end
  
end

module HelperMethods
  def fixture(name)
    File.read(File.dirname(__FILE__) +  "/../fixtures/#{name}.html")
  end
end

RSpec.configuration.include HelperMethods
RSpec.configuration.include CongressWebSitePaths