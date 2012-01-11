== Rails 2.3

  To create a new Rails 2.3.5 app based on the Luckie Template:

  rails my_app --database=mysql --template=~/projects/jumpstart/luckie_template.rb

== Rails 3

  To create a new Rails 3 app to deploy to EY:

  rails new my_new_app -J -T -d mysql -m ~/projects/jumpstart/ey_template.rb

  To create a new Rails 3 app to deploy to Heroku:

  rails new my_new_app --skip-bundle -T -d postgresql -m https://raw.github.com/luckie/Jumpstart/master/heroku_template.rb
