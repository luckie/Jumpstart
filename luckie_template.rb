# Standard Application Template
# Lee Smith 2010-09-07

# Delete unnecessary files
  run "rm public/index.html"

# Replace default js with jQuery
  run "rm -f public/javascripts/*"
  run "curl -L http://code.jquery.com/jquery-1.4.2.min.js > public/javascripts/jquery.js"

# Copy database.yml for distribution use
  run "cp config/database.yml config/database.example.yml"

# Set up .gitignore
  file '.gitignore', <<-END
.DS_Store
log/*.log
tmp/**/*
tmp/*
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
  gem 'erubis', :version => '>= 2.6.5'
  gem 'haml', :version => '>= 3.0.18'
  gem 'will_paginate', :version => '2.3.14'
  gem 'devise'
  gem 'warden'

  gem 'factory_girl', :version => '1.3.2'
  gem 'fakeweb', :version => '1.3.0'
  gem 'ffaker', :version => '0.4.0'
  gem 'mocha', :version => '0.9.8'
  gem 'rspactor', :version => '0.6.4'
  gem 'rspec', :version => '1.3.0', :lib => false
  gem 'rspec-rails', :version => '1.3.0', :lib => false
  gem 'shoulda', :version => '2.11.3', :lib => 'false'
  gem 'webrat', :version => '0.7.1'

# Install gems
  rake('gems:install')

# Test setup
  generate('rspec')
  run "rm -rf test/"
  run "mkdir spec/factories"

# Git it
  git :init
  git :add => '.'
  git :commit => "-a -m 'Initial commit.'"

# Done!
  puts "Done!"