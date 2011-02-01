rvmrc = <<-RVMRC
rvm --create use "ruby-1.8.7-p174@#{app_name}"
RVMRC

create_file ".rvmrc", rvmrc

gitignore = <<-GITIGNORE
*~
.DS_Store
capybara-*.html
config/database.yml
db/*.db
db/*.sql
doc/api
doc/app
log/*.log
*.swo
*.swp
*.swn
tmp/**/*
GITIGNORE

run 'rm .gitignore'
create_file '.gitignore', gitignore

gemfile = <<-GEMFILE
gem 'decent_exposure'
gem 'devise'
gem 'haml'
gem 'haml-rails'
gem 'will_paginate', '3.0.pre2'

group :development, :test do
  gem 'capybara'
  gem 'cucumber-rails'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'ffaker'
  gem 'launchy'
  gem 'pickler'
  gem 'rspec-rails'
  gem 'ruby-debug'
  gem 'shoulda'
  gem 'spork'
end
GEMFILE

append_file 'Gemfile', gemfile

# Database config
db = <<-DB
common: &common
  adapter: mysql
  encoding: utf8
  pool: 5
  reconnect: false
  username:
  password:
  socket: /tmp/mysql.sock

production:
  database: #{app_name}_production
  <<: *common

development:
  database: #{app_name}_development
  <<: *common

test: &test
  database: #{app_name}_test
  <<: *common

cucumber:
  <<: *test
DB

create_file "config/database.example.yml", db

# Replace default js with jquery
run "curl -L http://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js > public/javascripts/jquery.js"
run "curl -L https://github.com/rails/jquery-ujs/raw/master/src/rails.js > public/javascripts/rails.js"

gsub_file 'config/application.rb', 'config.action_view.javascript_expansions[:defaults] = %w()', 'config.action_view.javascript_expansions[:defaults] = %w(jquery rails)'

# Gitkeep some dirs
create_file "log/.gitkeep"
create_file "tmp/.gitkeep"

# Cleanup
run "rm -f app/views/layouts/application.html.erb"
run "rm -f public/index.html"
run "rm -f README"

# Create basic README file
file 'README.md', <<-EOF
Welcome to #{app_name.humanize}
===============================================================================

Getting Started
---------------

    clone git@github.com:luckie/#{app_name}.git
    hcd #{app_name}
    cp config/database.example.yml config/database.yml
    gem install bundler
    bundle

    # DB setup
    rake db:create:all
    rake db:setup

    # Run the test suites
    rake
EOF

# Git it
git :init
git :add => '.'

# Done!
notes = <<-NOTES

===============================================================================
Run the following commands to complete the setup of #{app_name}:

hcd #{app_name}
gem install bundler && bundle
rails g rspec:install && rails g cucumber:install --rspec --capybara
cp config/database.example.yml config/database.yml
rake db:create:all && rake db:migrate && rake db:setup
===============================================================================
NOTES

log notes
