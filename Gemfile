source 'https://rubygems.org'

gem 'rails', '5.2.2'
gem 'pg', '~> 1.0'
# Restrict capybara to a version lower than 3.
# With 3.0.1 there was trouble with 'Wrong number of arguments'
# when calling simple methods like `click_link` or `fill_in`
gem 'capybara', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2.1'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'bootsnap'
gem 'faker',  '~> 1.5'
gem 'devise', '~> 4.3'
gem 'faraday'
gem 'hashie', '~> 3.5'
gem 'jsonapi-resources'
gem 'multi_xml', '~> 0.6'
gem 'redis', '~> 4.0'
gem 'unicorn', '~> 5.4'
gem 'bootstrap', '~> 4.3.1'

group :development, :test do
  gem 'byebug'
  gem 'spring'
  gem 'rspec-rails', '~> 3.0'
  gem 'factory_bot_rails', '~> 4.5', require: false
end

group :development do
  gem 'rails-erd'
  gem 'listen'
  gem 'pry-rails'
  gem 'reek'
  gem 'rubocop'
  gem 'rubocop-rspec'
  gem 'rails_best_practices'
  gem 'rubycritic', require: false
  gem 'web-console', '~> 3.0'
end

group :test do
  gem 'database_cleaner'
  gem 'shoulda-matchers', '~> 4.0'
  gem 'sinatra', '~> 2.0'
  gem 'simplecov', require: false
  gem 'webmock', '~> 3.0'
end
