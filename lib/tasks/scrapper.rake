require 'scrapper'

namespace :scrapper do
  desc "Update data from congreso.es"
  task :scrape => :environment do
    WebMock.allow_net_connect!
    Scrapper.scrape
  end
end