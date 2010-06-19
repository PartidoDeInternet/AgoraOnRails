RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.time_zone = 'UTC'

  config.gem "progressbar"
  config.gem "mechanize"
  config.gem "authlogic"
  config.gem "inherited_resources", :version => "1.0.6" 
  config.gem "rspec", :version => "1.3.0"
  config.gem "rspec-rails", :version => "1.3.2"
  config.gem "capybara"  
  
  
  config.i18n.default_locale = :es
end