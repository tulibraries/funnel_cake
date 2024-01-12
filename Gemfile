# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem "rails", "7.0.8"

gem "base64", "0.1.1"
gem "blacklight", "~> 7.33.0"
gem "blacklight_oai_provider", github: "projectblacklight/blacklight_oai_provider", branch: "main"
gem "bootsnap", ">= 1.1.0", require: false
gem "bootstrap", "~> 4.6"
gem "dotenv-rails"
gem "fieldhand"
gem "funnel_cake_index", github: "tulibraries/funnel_cake_index"
gem "jquery-rails"
gem "okcomputer"
gem "pg"
gem "popper_js", "~> 1.16.1"
gem "puma", "~> 6.4"
gem "rsolr", ">= 1.0", "< 3"
gem "sass-rails", "~> 6.0"
gem "sprockets-rails"
gem "turbolinks", "~> 5"
gem "twitter-typeahead-rails", "0.11.1"
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem "uglifier", ">= 1.3.0"


group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "pry-rails"
  gem "rubocop",  require: false
  gem "rubocop-rails", require: false
  gem "vcr"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.9"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.1.0"
  gem "sqlite3"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "rspec"
  gem "rspec-rails"
  gem "webmock"
end
