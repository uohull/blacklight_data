require 'spec_helper'

describe Hull::Data::DatasetSolrMappingsConfigurationMapper do

  let(:test_dataset) do
    mock_model("Dataset", name: "Test dataset")
  end

  # Create some test dataset_header_props with a dummy dataset object
  let(:dataset_header_prop_one) do
    double("DatasetHeaderProp", name: "Test Header 1", dataset: test_dataset)
  end

  let(:dataset_header_prop_two) do
    double("DatasetHeaderProp", name: "Test Header 2", dataset: test_dataset)
  end

  let(:dataset_header_prop_three) do
    double("DatasetHeaderProp", name: "Test Header 3", dataset: test_dataset)
  end

  let(:dataset_header_prop_four) do
    double("DatasetHeaderProp", name: "Test Header 4", dataset: test_dataset)
  end

  # Solr mappings hash (not mocked the dataset_header_prop)
  let(:solr_mappings) {
    [{ dataset_header_prop: dataset_header_prop_one, solr_mapping:  { "test_tsim" => [:searchable, :displayable, :multivalued] }  },
      { dataset_header_prop: dataset_header_prop_two, solr_mapping: { "test_field_ts" => [:displayable, :multivalued], "test_field_si" => [:facetable], "test_ssort" => [:sortable]}  },
      { dataset_header_prop: dataset_header_prop_three, solr_mapping:  { "test_search_field_ti" => [:searchable] }  },
      { dataset_header_prop: dataset_header_prop_four, solr_mapping:  { "test_facet_field_si" => [:facetable] }  }
    ]
  }

  let(:config_mapper) { Hull::Data::DatasetSolrMappingsConfigurationMapper.new(solr_mappings) }
  
  describe "#map_header_props" do
    
    it "returns an array of BlacklightConfiguration objects that have been mapped from the DatasetHeaderProps" do
      blacklight_configs = config_mapper.get_blacklight_configurations
      expect(blacklight_configs).to be_an_instance_of(Array)
    end

    it "returns the correct index field type configs" do
      # Index field configurations are derived from 'displayable' dataset_headers

      blacklight_configs = config_mapper.get_blacklight_configurations

      # The label should be default to the DatasetHeaderProp.name value, solr_field and config.configuration should be as below... 
      expect(blacklight_configs.find do |config|
          config.dataset == test_dataset && config.label == "Test Header 1" && config.solr_field == "test_tsim" && config.configuration == "index"
        end).to_not be_nil

      expect(blacklight_configs.find do |config|
          config.dataset == test_dataset && config.label == "Test Header 2" && config.solr_field == "test_field_ts" && config.configuration == "index"
        end).to_not be_nil
    end

    it "returns the correct show field type configs" do
      # Show field configurations are derived from 'displayable' dataset_headers

      blacklight_configs = config_mapper.get_blacklight_configurations

      # The label should be default to the DatasetHeaderProp.name value, solr_field and config.configuration should be as below... 
      expect(blacklight_configs.find do |config|
          config.dataset == test_dataset && config.label == "Test Header 1" && config.solr_field == "test_tsim" && config.configuration == "show"
        end).to_not be_nil

      expect(blacklight_configs.find do |config|
          config.dataset == test_dataset && config.label == "Test Header 2" && config.solr_field == "test_field_ts" && config.configuration == "show"
        end).to_not be_nil

    end

    it "returns the correct facet field type configs" do
      # facet field configurations are derived from 'facetable' dataset_headers
      blacklight_configs = config_mapper.get_blacklight_configurations

      # The label should be default to the DatasetHeaderProp.name value, solr_field and config.configuration should be as below... 
      expect(blacklight_configs.find do |config|
          config.dataset == test_dataset && config.label == "Test Header 2" && config.solr_field == "test_field_si" && config.configuration == "facet"
        end).to_not be_nil

      expect(blacklight_configs.find do |config|
          config.dataset == test_dataset && config.label == "Test Header 4" && config.solr_field == "test_facet_field_si" && config.configuration == "facet"
        end).to_not be_nil

    end

    it "returns the correct search field type configs" do
      # Search field configurations are derived from 'searchable' dataset_headers
      blacklight_configs = config_mapper.get_blacklight_configurations

      # The label should be default to the DatasetHeaderProp.name value, solr_field and config.configuration should be as below... 
      expect(blacklight_configs.find do |config|
          config.dataset == test_dataset && config.label == "Test Header 1" && config.solr_field == "test_tsim" && config.configuration == "search"
        end).to_not be_nil

      expect(blacklight_configs.find do |config|
          config.dataset == test_dataset && config.label == "Test Header 3" && config.solr_field == "test_search_field_ti" && config.configuration == "search"
        end).to_not be_nil
    end

    it "returns the correct sort field type configs" do
      # Sort field configurations are derived from 'sortable' dataset_headers
      blacklight_configs = config_mapper.get_blacklight_configurations

      # The label should be default to the DatasetHeaderProp.name value, solr_field and config.configuration should be as below... 
      expect(blacklight_configs.find do |config|
          config.dataset == test_dataset && config.label == "Test Header 2" && config.solr_field == "test_ssort" && config.configuration == "sort"
        end).to_not be_nil   
    end

    it "returns a configuration for a title field" do
      blacklight_configs = config_mapper.get_blacklight_configurations

      # The label should be default to the DatasetHeaderProp.name value, solr_field and config.configuration should be as below... 
      expect(blacklight_configs.find do |config|
          # We are not too concerned about anything but a default being set...
          config.dataset == test_dataset && config.configuration == "title"
        end).to_not be_nil   
    end

  end
   

end
