# Dissertation - Maintenance Manual

\
Installation instructions:
- Ruby 2.6.5
- Rails 5.2.4
- Git
- Node.js
- Yarn
- Postgres SQL
- bundle install

\
Third party software required:
- Sendgrid Account for mailer service
- Heroku Account for production environment

\
To create an admin account:
- Go to https://extinction-rebellion-project.herokuapp.com/users/sign_up.
- Go to terminal and type the following sequnce:
- $ heroku run rails console
- $ @user = User.first (For first account that was created)
- $ @user.admin = true
- $ @user.save

\
To create an user account: 
- Go to https://extinction-rebellion-project.herokuapp.com/users/sign_up.


|               | Admin account  | User Account  |
| ------------- |:--------------:|:-------------:|
| Username:     | admin@admin.com|test@test.com  |
| Password:     | password       | test1234      |


*Warning: Admin control will be destroyed whenever database is refreshed.*

\
To add changes to 

\
List of gems and what they are for:
- JQuery Rails - Provides jQuery and the jQuery-ujs driver for your Rails 4+ application.
- Pg - Ruby interface to the PostgreSQL relational database management system.
- Devise - User authentication, it creates sign-up and sign-in forms, it also can be used to create user accounts for privacy. 
- ~~CanCanCan - Authorization library for Ruby and Ruby on Rails which restricts what resources a given user is allowed to access.~~ 
- Omniauth Facebook - Implementing 'Facebook sign in'.
- Puma - Simple, fast, threaded, and highly concurrent HTTP 1.1 server for Ruby/Rack applications.
- Sass Rails - Official integration for Ruby on Rails projects with the Sass stylesheet language.
- Uglifier - Minifies JavaScript files by wrapping UglifyJS to be accessible in Ruby.
- Duktape - Embeddable Javascript engine, with a focus on portability and compact footprint.
- Coffee Rails -  Adapter for the Rails asset pipeline. 
- Turbolinks -  Speed up navigating between pages of your application.
- Jbuilder - Template engine for rendering a JSON response.
- Bootsnap - Boot large ruby/rails apps faster. 
- Byebug - Simple to use, feature rich debugger for Ruby.
- Rspec Rails - Brings the RSpec testing framework to Ruby on Rails as a drop-in alternative to its default testing framework.
- Web Console - Debugging tool for your Ruby on Rails applications.
- Capybara -  Integration testing tool for rack based web applications. It simulates how a user would interact with a website.
- Selenium Webdriver -  Tool for writing automated tests of websites. It aims to mimic the behaviour of a real user, and as such interacts with the HTML of the application.
- Chromedriver Helper - Installs an executable chromedriver in the gem path.
- tzinfo-data - Contains data from the IANA Time Zone database packaged as Ruby modules for use with TZInfo.
- Koala - Lightweight, flexible Ruby SDK for Facebook.
- Gmaps4rails - Enables easy Google map + overlays creation.

 
Future adaptation and extension
