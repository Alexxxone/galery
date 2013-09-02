source 'https://rubygems.org'

ruby '2.0.0'
gem 'rails', '3.2.13'

gem 'kaminari'

gem 'devise'
gem 'activeadmin'
gem 'ransack'
gem 'omniauth'
gem "omniauth-facebook"

gem 'simple_form'
gem 'gon'
gem 'rabl-rails'
gem "i18n-js"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby
  gem 'libv8', '~> 3.11.8'
  gem "jquery-ui-rails"
  gem 'jquery-rails'
  gem 'bootstrap-sass'
  gem "twitter-bootstrap-rails"

end


# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Deploy with Capistrano
# gem 'capistrano'

gem 'therubyracer', :platforms => :ruby, :require => 'v8'

gem 'figaro'
gem 'haml-rails'
gem 'simple_captcha', :git => 'git://github.com/galetahub/simple-captcha.git'
gem 'pg'
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

  gem 'thin'
  gem 'annotate'
end

group :production do
  gem 'unicorn'
end

group :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'simplecov', :require => false
  gem 'shoulda-matchers'
  gem 'database_cleaner'
  gem 'capybara'
  gem "selenium-webdriver"
  gem 'database_cleaner'
  gem 'email_spec'
end



