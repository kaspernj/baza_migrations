source "http://rubygems.org"
# Add dependencies required to use your gem here.
# Example:
#   gem "activesupport", ">= 2.3.5"

gem "baza", "~> 0.0.19" # path: "/Users/kaspernj/Dev/Ruby/baza"
gem "string-cases", "~> 0.0.1"
gem "auto_autoloader"

# Add dependencies to develop your gem here.
# Include everything needed to run rake, tests, features, etc.
group :development do
  gem "pry"
  gem "rspec", "~> 3.3.0"
  gem "rdoc", "~> 3.12"
  gem "bundler", "~> 1.0"
  gem "jeweler", "~> 2.0.1"
  gem "jdbc-sqlite3", platform: :jruby
  gem "sqlite3", platform: :ruby
  gem "wref", "0.0.8"
  gem "rubocop", require: false
  gem "best_practice_project", require: false, github: "kaspernj/best_practice_project"
end

group :test do
  gem "codeclimate-test-reporter", group: :test, require: nil
end
