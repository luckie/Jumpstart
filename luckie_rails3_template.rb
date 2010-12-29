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
  gem 'ruby-debug'
  gem 'will_paginate', '3.0.pre2'

  gem 'capybara', '~> 0.4.0', :group => [:development, :test]
  gem 'cucumber-rails', :group => [:development, :test]
  gem 'database_cleaner', :group => [:development, :test]
  gem 'factory_girl_rails', :group => [:development, :test]
  gem 'ffaker', :group => [:development, :test]
  gem 'launchy', :group => [:development, :test]
  gem 'mocha', '0.9.7', :group => [:development, :test]
  gem 'pickler', '~> 0.1.7', :group => [:development, :test]
  gem 'rspec-rails', :group => [:development, :test]
  gem 'shoulda', :group => [:development, :test]
  gem 'spork', :group => [:development, :test]

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
