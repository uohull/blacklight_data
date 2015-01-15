require 'spec_helper'
require_relative '../../../lib/blacklight/field_configuration'

class BlacklightConfigurationTestClass
  include Blacklight::Configurable  
  configure_blacklight do |config|

    config.blacklight_solr = RSolr.connect(Blacklight.solr_config)
      
    ## Default parameters to send to solr for all search-like requests. See also SolrHelper#solr_search_params
    config.default_solr_params = { 
      :qt => 'search',
      :rows => 10 
    }
    config.add_field_configuration_to_solr_request!

    # Have BL send all facet field names to Solr, which has been the default
    # previously. Simply remove these lines if you'd rather use Solr request
    # handler defaults, or have no facets.
    config.add_facet_fields_to_solr_request!
    config.spell_max = 5
  end
end

describe Blacklight::FieldConfiguration do
  
  let(:test_config_instance) { BlacklightConfigurationTestClass.new }
  let(:field_configuration) { Blacklight::FieldConfiguration.new}

  let(:title_field)   { "header_one_tsi" }
  let(:index_fields)  { { "Header one" => "header_one_tsi", "Header two" => "header_two_ss" } }
  let(:show_fields)   { { "Header one" => "header_one_tsi", "Header two" => "header_two_ss" } }
  let(:facet_fields)  { { "Facetable field one" => "facetable_one_ssi", "Facetable field two" => "facetable_two_ssi" } }
  let(:search_fields) { { "Indexed field one" => "indexed_field_one_si", "Indexed field two" => "indexed_field_two_si" } }
  let(:sort_fields)   { { "Header one" => "header_one_tsi" }}

   
  describe "#field_configurations" do
    before(:each) do 
      field_configuration.blacklight_config = test_config_instance.blacklight_config
    end

    
    it "will add the expected index_fields to a BlacklightConfiguration instance" do
      # Set the field configuration index fields
      field_configuration.index = index_fields
      config = field_configuration.generate_field_configurations

      index_fields = config.index_fields

      expect(index_fields).to include( "header_one_tsi" => Blacklight::Configuration::IndexField.new(field:"header_one_tsi", label:"Header one") )
      expect(index_fields).to include( "header_two_ss" => Blacklight::Configuration::IndexField.new(field:"header_two_ss", label:"Header two") )
    end

    it "will add the expected show_fields to a BlacklightConfiguration instance" do
      field_configuration.show = show_fields
      config = field_configuration.generate_field_configurations

      show_fields = config.show_fields
      
      expect(show_fields).to include( "header_one_tsi" => Blacklight::Configuration::ShowField.new(field: "header_one_tsi", label: "Header one") )
      expect(show_fields).to include( "header_two_ss" => Blacklight::Configuration::ShowField.new(field: "header_two_ss", label: "Header two") )
    end

    it "will add the expected facet fields to a BlacklightConfiguration instance" do
      field_configuration.facet = facet_fields
      config = field_configuration.generate_field_configurations

      facet_fields = config.facet_fields
      expect(facet_fields).to include( "facetable_one_ssi" => Blacklight::Configuration::FacetField.new(collapse:true, show:true, field:"facetable_one_ssi", label:"Facetable field one") )
      expect(facet_fields).to include( "facetable_two_ssi" => Blacklight::Configuration::FacetField.new(collapse:true, show:true, field:"facetable_two_ssi", label:"Facetable field two") )
    end

    it "will add the expected show title field to a BlacklightConfiguration instance" do
      field_configuration.title = title_field
      config = field_configuration.generate_field_configurations

      show_title_field_conf = config.show.title_field
      expect(show_title_field_conf).to eq title_field
    end

    it "will add the expected index title field to a BlacklightConfiguration instance" do
      field_configuration.title = title_field
      config = field_configuration.generate_field_configurations

      index_title_field_conf = config.index.title_field
      expect(index_title_field_conf).to eq title_field
    end

    it "will add the expected sort fields to a BlacklightConfiguration instance" do
      field_configuration.sort = sort_fields
      config = field_configuration.generate_field_configurations
     
      sort_conf = config.sort_fields

      # Ascending option
      expect(sort_conf).to include( "header_one_tsi asc" => Blacklight::Configuration::SortField.new(label: "Header one (ascending)", field: "header_one_tsi asc", sort: "header_one_tsi asc", key: "header_one_tsi asc"))
      # Descending option
      expect(sort_conf).to include( "header_one_tsi desc" => Blacklight::Configuration::SortField.new(label: "Header one (descending)", field: "header_one_tsi desc", sort: "header_one_tsi desc", key: "header_one_tsi desc"))
    end

    it "will add the expected search fields to an 'all_fields' BlacklightConfiguration instance" do
      # This will include the search fields as individual search items, and inclusion within 'all_fields'
      field_configuration.search = search_fields
      config = field_configuration.generate_field_configurations

      search_config = config.search_fields
      expect(search_config).to include( "all_fields" => Blacklight::Configuration::SearchField.new( field: "all_fields",
                               solr_local_parameters: { qf: "indexed_field_one_si indexed_field_two_si" }, key: "all_fields", label: "All Fields", qt: "search" ))
    end

    it "will add the expected search fields to individual search handlers within the BlacklightConfiguration instance" do 
      field_configuration.search = search_fields
      config = field_configuration.generate_field_configurations

      search_config = config.search_fields

      # First bl search handler
      expect(search_config).to include( "Indexed field one" => Blacklight::Configuration::SearchField.new( field: "Indexed field one",
                               solr_local_parameters: { qf: "indexed_field_one_si" }, key: "Indexed field one", label: "Indexed Field One", qt: "search" ))

      # Second bl search handler
      expect(search_config).to include( "Indexed field two" => Blacklight::Configuration::SearchField.new( field: "Indexed field two",
                               solr_local_parameters: { qf: "indexed_field_two_si" }, key: "Indexed field two", label: "Indexed Field Two", qt: "search" ))
    end
  
  end   

end