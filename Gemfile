# frozen_string_literal: true

source "https://rubygems.org"

gem "bcrypt", "~> 3.1.7"
gem "bootsnap", require: false
gem "kamal", require: false
gem "name_of_person"
gem "oj"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "rails", "~> 8.0.2", ">= 8.0.2.1"
gem "solid_cable"
gem "solid_cache"
gem "solid_queue"
gem "thruster", require: false
gem "vite_rails"

group :development, :test do
  gem "bullet"
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  gem "rails_best_practices"
  gem "reek"
  gem "rspec-rails", "~> 8.0"
  gem "rubocop-rails-omakase", require: false
  gem "rubocop-rspec", require: false
end

group :development do
  gem "annotaterb"
  gem "web-console"
end
