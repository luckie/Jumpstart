# Delete unnecessary files
  run "rm public/index.html"
  run "rm README"

# Create basic README file
  file 'README', <<-EOF
    Basic Rails 3 App based on Luckie's Rails Template
  EOF

# Replace default js with jQuery
  run "rm -f public/javascripts/*"
  run "curl -L http://code.jquery.com/jquery-1.4.4.min.js > public/javascripts/jquery.js"

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
  gem 'decent_exposure', '1.0.0.rc1'
  gem 'devise', '1.1.2'
  gem 'haml'
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
    gem 'rspec-rails', '2.0.1'
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
