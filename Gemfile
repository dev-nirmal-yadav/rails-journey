# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem 'nokogiri'

group :development, :test do
  gem 'rubocop'
end

group :development do
  gem 'webrick', '~> 1.7'
  gem 'yard'
end

group :test do
  gem 'rspec'
  gem 'simplecov'
end
