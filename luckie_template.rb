# Delete unnecessary files
  run "rm public/index.html"
  run "rm README"

# Create basic README file
  file 'README', <<-EOF
    Basic Rails 3 App based on Luckie's Rails Template
  EOF

# Replace default js with jQuery
  run "rm -f public/javascripts/*"
  run "curl -L http://code.jquery.com/jquery-1.4.2.min.js > public/javascripts/jquery.js"

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
  gem 'haml'
  gem 'will_paginate', '3.0.pre2'
  gem 'devise'
  gem 'warden'

  gem 'factory_girl', :group => :test
  gem 'ffaker', :group => :test
  gem 'mocha', :group => :test
  gem 'rspactor', :group => :test
  gem 'webrat', :group => :test
  gem 'shoulda', :group => :test
  gem 'rspec-rails', '2.0.0.beta.20', :group => [:test, :development]

# Install gems
  run "bundle install"

# Test setup
  puts "Generating Rspec"
  generate('rspec:install')
  run "rm -rf test/"
  run "mkdir spec/factories"

# Git it
  git :init
  git :add => '.'
  git :commit => "-a -m 'Initial commit.'"

# Done!
  puts "Done!"
