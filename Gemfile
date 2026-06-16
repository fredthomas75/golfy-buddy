source 'https://rubygems.org'
ruby '3.3.6'

# --- Core ---
gem 'rails', '~> 7.2.0'
gem 'pg', '~> 1.5'                 # was '~> 0.21' (won't compile against modern libpq)
gem 'puma', '~> 6.4'
gem 'bootsnap', '~> 1.18', require: false

# --- Asset pipeline ---
# Webpacker removed (unmaintained, won't build on Node 22). JS via esbuild,
# CSS via Dart Sass, both served through Sprockets.
gem 'sprockets-rails'
gem 'jsbundling-rails', '~> 1.3'
gem 'cssbundling-rails', '~> 1.4'
gem 'turbolinks', '~> 5.2'         # kept for now; Turbo migration is out of scope

# --- Auth / authorization ---
gem 'devise', '~> 4.9'
gem 'pundit', '~> 2.3'

# --- Views / forms / pagination ---
gem 'haml-rails', '~> 2.0'
gem 'simple_form', '~> 5.3'
gem 'jbuilder', '~> 2.12'
gem 'will_paginate', '~> 4.0'
gem 'will_paginate-bootstrap4'
gem 'country_select', '~> 9.0'
gem 'gravatar_image_tag'
gem 'font-awesome-sass', '~> 5.9'  # stay on FA5 to avoid renaming icons across views

# --- Search / geo ---
gem 'pg_search', '~> 2.3'
gem 'filterrific'                  # latest; AJAX filtering depends on jQuery
gem 'geocoder', '~> 1.8'

# --- Image uploads ---
gem 'carrierwave', '~> 3.0'        # was '~> 1.2'
gem 'cloudinary'                   # version coupled to CarrierWave — verify pairing

# --- Messaging / social ---
gem 'mailboxer'                    # UNMAINTAINED — expect Rails 7 runtime patches/fork
gem 'has_friendship'               # older gemspec capped Rails < 5.3 — using latest

group :development do
  gem 'web-console'
end

group :development, :test do
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'listen', '~> 3.8'
  gem 'dotenv-rails'
  gem 'faker'
end
