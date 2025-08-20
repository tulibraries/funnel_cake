# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem "rails", "7.2.2.2"

gem "base64", "0.3.0"
gem "blacklight", "~> 8.12.2"
gem "blacklight_oai_provider", github: "projectblacklight/blacklight_oai_provider", branch: "main"
gem "bootsnap", ">= 1.1.0", require: false
gem "bootstrap"
gem "cssbundling-rails", "~> 1.4"
gem "dotenv-rails"
gem "fieldhand"
gem "funnel_cake_index", github: "tulibraries/funnel_cake_index"
gem "importmap-rails", "~> 2.2"
gem "jquery-rails"
gem "okcomputer"
gem "pg"
gem "popper_js", ">= 2.11.8"
gem "propshaft", "~> 1.2"
gem "puma", "~> 6.6"
gem "rsolr", ">= 1.0", "< 3"
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
  gem "listen", ">= 3.0.5", "< 3.10"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.1.0"
  gem "sqlite3"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "launchy"
  gem "rspec"
  gem "rspec-rails"
  gem "webmock"
end

group :production do
  gem "dalli"
  gem "connection_pool"
end
