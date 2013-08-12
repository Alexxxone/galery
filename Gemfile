source 'https://rubygems.org'

ruby '2.0.0'
gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'devise'
gem 'activeadmin'

gem 'omniauth'
gem "omniauth-facebook"

gem 'kaminari'
gem 'ransack'

gem 'gon'
gem 'rabl-rails'
gem "i18n-js"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby
  gem 'libv8', '~> 3.11.8'
  gem 'uglifier', '>= 1.0.3'
end
gem "jquery-ui-rails"
gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
gem 'therubyracer', :platforms => :ruby, :require => 'v8'
gem 'bootstrap-sass'
gem "twitter-bootstrap-rails"
gem 'figaro'
gem 'haml-rails'
gem 'simple_captcha', :git => 'git://github.com/galetahub/simple-captcha.git'
gem 'pg'
gem 'simple_form'
gem "rmagick", "~> 2.13.2"
gem 'carrierwave'

gem 'pusher'


#parsing
gem "nokogiri"
gem "curb"




group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :rbx]
  gem 'html2haml'
  #optimisation
  gem 'bullet'
  gem 'ruby-growl'
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'puma'
  gem 'thin'
  gem 'annotate'
end

group :production do
  gem 'unicorn'
end

group :test do
  gem 'simplecov', :require => false
  gem 'shoulda-matchers'
  gem 'database_cleaner'
  gem 'capybara'
  gem "selenium-webdriver"
  gem 'database_cleaner'
  gem 'email_spec'
end

