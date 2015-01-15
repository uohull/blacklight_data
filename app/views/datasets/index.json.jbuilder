json.array!(@datasets) do |dataset|
  json.extract! dataset, :id, :data_file
  json.url dataset_url(dataset, format: :json)
end
