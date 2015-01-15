json.array!(@dataset_header_props) do |dataset_header_prop|
  json.extract! dataset_header_prop, :id, :name, :index, :display, :facet, :multivalued, :dataset_id
  json.url dataset_header_prop_url(dataset_header_prop, format: :json)
end
