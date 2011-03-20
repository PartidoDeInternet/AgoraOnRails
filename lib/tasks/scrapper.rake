require 'scrapper'

namespace :scrapper do
  desc "Update data from congreso.es"
  task :scrape => :environment do
    Scrapper.scrape
  end
end