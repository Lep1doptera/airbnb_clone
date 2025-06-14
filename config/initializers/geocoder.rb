# config/initializers/geocoder.rb
Geocoder.configure(
  # [...]
  timeout: 5, # seconds
  lookup: :mapbox, # Defaults to :nominatim, which is less reliable but free
  api_key: Rails.application.credentials.dig(:mapbox, :api_key),
  units: :km, # Defaults to miles (:mi)
  # [...]
)
