# Delete unnecessary files
  run "rm public/index.html"
  run "rm README"

# Create basic README file
  file 'README', <<-EOF
    README
  EOF

# Replace default js with jQuery
  run "rm -f public/javascripts/*"
  run "curl -L http://code.jquery.com/jquery-1.4.4.min.js > public/javascripts/jquery.js"
  run "curl -L https://github.com/rails/jquery-ujs/raw/master/src/rails.js > public/javascripts/rails.js"

# Copy database.yml for distribution use
  run "cp config/database.yml config/database.example.yml"

  open('.gitignore', 'a') { |f|
    f.puts '.DS_Store'
    f.puts 'config/database.yml'
    f.puts 'config/deploy.rb'
    f.puts 'doc/api'
    f.puts 'doc/app'
    f.puts '*.swo'
    f.puts '*.swp'
    f.puts '*.swn'
  }

# Declare global gems
  gem 'decent_exposure', '1.0.0.rc3'
  gem 'devise'
  gem 'haml'
  gem 'haml-rails'
  gem 'pg'
  gem 'rails', '3.0.3'
  gem 'ruby-debug'
  gem 'will_paginate', '3.0.pre2'

  group :development, :test do
    gem 'capybara', '~> 0.4.0'
    gem 'cucumber-rails'
    gem 'database_cleaner'
    gem 'factory_girl_rails'
    gem 'ffaker'
    gem 'launchy'
    gem 'mocha', '0.9.7'
    gem 'pickler', '~> 0.1.7'
    gem 'rspec-rails'
    gem 'shoulda'
    gem 'spork'
  end

# Install gems
  run "bundle install"

# Test setup
  generate('cucumber:install --rspec --capybara')
  generate('rspec:install')
  run "rm -rf test/"
  run "mkdir spec/factories"
  run "mkdir spec/data"

# Git it
  git :init
  git :add => '.'
  git :commit => "-a -m 'Initial commit.'"

# Done!
  puts "Done!"
