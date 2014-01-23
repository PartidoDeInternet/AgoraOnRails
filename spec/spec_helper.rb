require 'coveralls'
Coveralls.wear!('rails')

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'webmock/rspec'
require 'capybara/poltergeist'
include Warden::Test::Helpers

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|  
  config.include WebMock::API
  config.use_transactional_fixtures = false
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  
  config.before(:each) do
    Capybara.reset_sessions!
  end
  
  config.before(:each, :js) do
    WebMock.allow_net_connect!
    VCR.configure do |c|
      c.ignore_localhost = true
    end
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
  end

  config.before(:each) do
    DatabaseCleaner.clean
  end

end

Capybara.javascript_driver = :poltergeist
