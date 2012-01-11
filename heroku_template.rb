file '.rvmrc', "rvm --create use \"ruby-1.9.2-p290@#{app_name}\""

run 'rm .gitignore'
file '.gitignore', <<-GITIGNORE
*~
.DS_Store
.bundle
config/database.yml
log/*.log
*.swo
*.swp
tmp/
tags
GITIGNORE


gem 'decent_exposure'
gem 'devise'
gem 'haml'
gem 'pg'

gem_group :test, :development do
  gem 'heroku'
  gem 'ruby-debug19', require: 'ruby-debug'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'escape_utils'
  gem 'fabrication'
  gem 'launchy'
  gem 'rspec-rails'
  gem 'ruby-debug19', require: 'ruby-debug'
  gem 'shoulda'
end

# Database config
file 'config/database.example.yml', <<-DB
<% ['development', 'test].each do |env| %>
<%= env %>:
  database: <%= "\#{Rails.root.basename.to_s.underscore}_\#{env}" %>
  adapter: postgresql
  encoding: unicode
  pool: 5
  username:
  password:
  min_messages: warning
<% end %>
DB

run 'cp config/database{.example,}.yml'

# Cleanup
run "rm app/views/layouts/application.html.erb"
run "rm public/index.html"

# Create basic README file
file 'README.md', <<-EOF
# Welcome to #{app_name.humanize}

## Getting Started

    git clone git@github.com:luckie/#{app_name}.git
    hcd #{app_name}
    cp config/database{.example,}.yml
    gem install bundler
    bundle

    # DB setup
    rake db:create:all
    rake db:setup

    # Run the test suites
    rake

## Heroku Setup

    git remote add staging git@heroku.com:heroku-app-name-staging.git

    git remote add production git@heroku.com:heroku-app-name.git
EOF

git :init
git :add => '.'

# Done!
log <<-NOTES

===============================================================================
Run the following commands to complete the setup of #{app_name}:

pcd #{app_name}
gem install bundler
bundle install
rails g devise:install
rails g rspec:install
cp config/database.example.yml config/database.yml
rake db:create:all db:migrate db:setup
===============================================================================
NOTES
