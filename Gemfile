source 'https://rubygems.org'

gem 'rails', '3.2.1'
gem 'jquery-rails'
gem 'devise'
gem 'simple_form'
gem 'country_select'


group :production do
	gem 'pg'
end

group :development, :test do 
  gem 'sqlite3'
end 

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'bootstrap-sass', '~> 2.3.2.2'
end

#Be sure to have a copy of the Bootstrap stylesheet available on your application, 
#you can get it on http://twitter.github.com/bootstrap.
#Inside your views, use the 'simple_form_for' with one of the Bootstrap form
#classes, '.form-horizontal', '.form-inline', '.form-search' or
#'.form-vertical', as the following:
# = simple_form_for(@user, :html => {:class => 'form-horizontal' }) do |form|


