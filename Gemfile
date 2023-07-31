# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem "rails", "6.1.7.4"

gem "blacklight"
gem "blacklight_oai_provider", github: "projectblacklight/blacklight_oai_provider", branch: "main"
gem "bootsnap", ">= 1.1.0", require: false
gem "fieldhand"
gem "funnel_cake_index", github: "tulibraries/funnel_cake_index"
gem "okcomputer"
gem "puma", "~> 6.3"
gem "sass-rails", "~> 6.0"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"
gem "bootstrap", "~> 4.6"
gem "dotenv-rails"
gem "jquery-rails"
gem "pg"
gem "popper_js", "~> 1.16.1"
gem "rsolr", ">= 1.0", "< 3"
gem "twitter-typeahead-rails", "0.11.1"
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]


group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "pry-rails"
  gem "rubocop",  require: false
  gem "rubocop-rails", require: false
  gem "vcr"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.9"
  gem "web-console", ">= 3.3.0"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.1.0"
  gem "sqlite3"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "rspec"
  gem "rspec-rails"
  gem "webmock"

end
