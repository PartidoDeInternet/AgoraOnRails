source 'http://rubygems.org'
ruby '2.0.0'

gem 'rails', "~> 4.0.2"

gem 'mechanize'
gem 'inherited_resources', github: "josevalim/inherited_resources"
gem 'simple_form'
gem 'rails_autolink'
gem 'jbuilder'
gem 'gon'
gem 'rack-cache'

gem 'devise'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'pg'

gem 'faraday'
gem 'faraday_middleware'
gem 'hashie'
gem 'json'

gem 'turbolinks'
gem 'sass-rails'
gem "compass-rails"
gem 'coffee-rails'
gem 'uglifier'
gem 'bootstrap-sass'

gem 'jquery-rails'

#Image manipulation
gem "carrierwave"
gem "rmagick"


group :staging, :production do
  gem 'unicorn'
  gem 'dalli'
  gem "memcachier"
  gem 'kgio'
  gem 'rails_12factor'
end

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'steak'
  gem 'capybara'
  gem 'poltergeist'
  gem 'launchy'
  gem 'byebug'
  gem 'database_cleaner'
end

group :test do
  gem 'vcr'
  gem 'webmock', '1.15'
  gem 'coveralls', require: false
end