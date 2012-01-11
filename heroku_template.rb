rvmrc = <<-RVMRC
rvm --create use "ruby-1.9.2-p290@#{app_name}"
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
create_file ".gitignore", gitignore

gem 'decent_exposure'
gem 'devise'
gem 'haml'

gem_group :development do
  gem 'heroku'
  gem 'ruby-debug19', require: 'ruby-debug'
end

gem_group :test do
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
db = <<-DB
<% ['development', 'test].each do |env| %>
<%= env %>:
  database: <%= "#{Rails.root.basename.to_s.underscore}_#{env}" %>
  adapter: postgresql
  encoding: unicode
  pool: 5
  username:
  password:
  min_messages: warning
<% end %>
DB

create_file "config/database.example.yml", db

# Gitkeep some dirs
create_file "log/.gitkeep"
create_file "tmp/.gitkeep"

# Cleanup
run "rm -f app/views/layouts/application.html.erb"
run "rm -f public/index.html"
run "rm -f README"

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
notes = <<-NOTES

===============================================================================
Run the following commands to complete the setup of #{app_name}:

hcd #{app_name}
gem install bundler
bundle install
rails g rspec:install
rails g devise:install
cp config/database.example.yml config/database.yml
rake db:create:all db:migrate db:setup
===============================================================================
NOTES

log notes
