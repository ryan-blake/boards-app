source 'https://rubygems.org'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
ruby '2.3.3'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
# Use sqlite3 as the database for Active Record
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'binding_of_caller'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'bootstrap-sass'
gem 'devise'
gem 'high_voltage'
gem 'pg'
gem 'unicorn'
gem 'unicorn-rails'
gem 'rails_12factor'
gem 'stripe'
gem 'omniauth-stripe-connect'
gem "refile", require: "refile/rails", github: 'manfe/refile'
gem "refile-mini_magick"
gem "refile-s3", '~> 0.2.0'
gem 'geocoder'
gem 'faker'
gem 'omniauth-facebook'
gem 'kaminari'
gem 'geocomplete_rails'
gem 'font-awesome-sass'
gem "simple_calendar"
gem 'validates_timeliness', '~> 4.0'
gem 'validates_overlap'
gem 'momentjs-rails', '>= 2.9.0'
gem 'bootstrap3-datetimepicker-rails'
gem 'slim'
gem "jquery-slick-rails"
gem 'groupdate'
gem "chartkick"
gem "sidekick"
gem "sinatra", github:'sinatra/sinatra'
gem "sidekiq-cron", "~> 0.4.0"
gem 'rack-mini-profiler', '~> 0.10'


# gem 'data-confirm-modal'
group :development do
  gem 'better_errors'
  gem 'hub', :require=>nil
  gem 'rails_apps_pages'
  gem 'rails_apps_testing'
  gem 'rails_layout'
  gem 'spring-commands-rspec'
  gem 'annotate'
  gem 'figaro'
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
    # Call 'byebug' anywhere in the code to stop execution and get a debugger console
    gem 'byebug', platform: :mri
    gem 'sqlite3'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver'
end
