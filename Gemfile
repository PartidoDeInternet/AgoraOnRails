source 'http://rubygems.org'
ruby '2.0.0'

gem 'rails', "~> 4.0.0"

gem 'mechanize'
gem 'inherited_resources'
gem 'simple_form'
gem 'rails_autolink'
gem 'client_side_validations', github: 'bcardarella/client_side_validations', branch: '4-0-beta'
gem 'jbuilder'
gem 'gon'
gem 'rack-cache'

gem 'devise', github: 'plataformatec/devise', branch: 'rails4'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'pg'

gem 'sass-rails'
gem "compass-rails", "~> 2.0.alpha.0"
gem 'coffee-rails'
gem 'uglifier'
gem 'bootstrap-sass'

gem 'jquery-rails' 

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
  gem 'webmock'
  gem 'coveralls', require: false
end