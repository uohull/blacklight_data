json.array!(@blacklight_configurations) do |blacklight_configuration|
  json.extract! blacklight_configuration, :id, :configuration, :key, :value
  json.url blacklight_configuration_url(blacklight_configuration, format: :json)
end
