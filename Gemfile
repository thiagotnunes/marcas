source 'https://rubygems.org'

gem 'rails', '3.2.2'

gem 'sqlite3', :group => [:development, :test]
gem 'pry', :group => [:development, :test]
gem 'pg', :group => :production

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

group :test do
  gem 'rspec-rails'
  gem 'shoulda'
  gem 'factory_girl_rails'
  gem 'cucumber-rails', "~> 1.0", require: false
  gem 'database_cleaner'
  gem 'launchy'
  gem 'watchr'
  gem 'spork'
  gem 'foreman'
end

group :development do
  gem 'heroku'
end

gem 'sorcery'
gem 'cancan'
gem 'bartt-ssl_requirement', '~>1.4.0', :require => 'ssl_requirement'
gem 'carrierwave'
gem 'nested_form', :git => 'https://github.com/ryanb/nested_form.git'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
