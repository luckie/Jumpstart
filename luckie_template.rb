# Delete unnecessary files
  run "rm public/index.html"
  run "rm README"

# Create basic README file
  file 'README', <<-EOF
    Basic Rails 2.3.5 App based on Luckie's Rails Template
  EOF

# Replace default js with jQuery
  run "rm -f public/javascripts/*"
  run "curl -L http://code.jquery.com/jquery-1.4.2.min.js > public/javascripts/jquery.js"

# Copy database.yml for distribution use
  run "cp config/database.yml config/database.example.yml"

# Create .gitignore file with basic options
  file '.gitignore', <<-END
  .DS_Store
  log/*.log
  tmp/**/*
  config/database.yml
  config/deploy.rb
  db/*.sqlite3
  doc/api
  doc/app
  *.swo
  *.swp
  *.swn
  END

# Declare global gems
  gem 'haml'
  gem 'will_paginate'
  gem 'devise', :version => '1.0.8'
  gem 'warden', :version => '1.9.7'

  gem 'factory_girl'
  gem 'ffaker'
  gem 'mocha'
  gem 'rspactor'
  gem 'webrat'
  gem 'shoulda'
  gem 'rspec-rails'

# Install gems
  rake("gems:install")

# Test setup
  puts "Generating Rspec"
  generate('rspec')
  run "rm -rf test/"
  run "mkdir spec/factories"

# Git it
  git :init
  git :add => '.'
  git :commit => "-a -m 'Initial commit.'"

# Done!
  puts "Done!"
