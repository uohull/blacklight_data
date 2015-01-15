require 'spec_helper'
require_relative '../../lib/blacklight/field_configuration'

class BlacklightConfigurationTestClass
  include Blacklight::Configurable  
  configure_blacklight do |config|
    config.add_field_configuration_to_solr_request!
    config.add_facet_fields_to_solr_request!
    config.spell_max = 5
  end
end


describe BlacklightConfigurationList do

  let(:blacklight_config_list) { BlacklightConfigurationList.new([]) }
  
  describe "#initialize" do
    before(:all) do      
      @blacklight_configuration_array = %w(config1 config2 config3).map do |config|
        BlacklightConfiguration.new(configuration: "TestConfig", label: config, solr_field: "#{config}_test", enabled: true)
      end  
    end

    it "will let me specify an array of BlacklightConfigurations" do
      test = BlacklightConfigurationList.new(@blacklight_configuration_array)
      expect(test.configuration_list).to eq @blacklight_configuration_array
    end
  end

  describe "#title_configs" do

    before(:all) do
      @title_configuration = BlacklightConfiguration.new(configuration: "title", label:  "", solr_field: "title_tsim", enabled: true)
    end

    it "will return the title configuration from the list" do
      blacklight_config_list.configuration_list << @title_configuration
      expect(blacklight_config_list.title_configs).to include(@title_configuration)
    end
  end


  describe "#index_configs" do

    before(:all) do
      @index_configuration_one = BlacklightConfiguration.new(configuration: "index", label:  "Title", solr_field: "title_tsim", enabled: true)
      @index_configuration_two = BlacklightConfiguration.new(configuration: "index", label:  "Abstract", solr_field: "description_tsim", enabled: true)
      @index_configuration_three = BlacklightConfiguration.new(configuration: "index", label:  "Author", solr_field: "author_tsim", enabled: false)
    end

    it "will return the title configuration from the list" do
      blacklight_config_list.configuration_list << @index_configuration_one
      blacklight_config_list.configuration_list << @index_configuration_two

      expect(blacklight_config_list.index_configs).to include(@index_configuration_one)
      expect(blacklight_config_list.index_configs).to include(@index_configuration_two)
    end

    it "will not return a configuration when it is not enabled" do
       blacklight_config_list.configuration_list << @index_configuration_three
       expect(blacklight_config_list.index_configs).to_not include(@index_configuration_three)
    end

  end

  describe "#show_configs" do

    before(:all) do
      @show_configuration = BlacklightConfiguration.new(configuration: "show", label:  "Description", solr_field: "description_tsim", enabled: true)
    end

    it "will return the title configuration from the list" do
      blacklight_config_list.configuration_list << @show_configuration
      expect(blacklight_config_list.show_configs).to include(@show_configuration)
    end
  end


  describe "#facet_configs" do

    before(:all) do
      @facet_configuration_one = BlacklightConfiguration.new(configuration: "facet", label:  "Make", solr_field: "facet_field", enabled: true)
      @facet_configuration_two = BlacklightConfiguration.new(configuration: "facet", label:  "Class", solr_field: "facet_field_two", enabled: true)
    end

    it "will return the title configuration from the list" do
      blacklight_config_list.configuration_list << @facet_configuration_one
      blacklight_config_list.configuration_list << @facet_configuration_two

      expect(blacklight_config_list.facet_configs).to include(@facet_configuration_one)
      expect(blacklight_config_list.facet_configs).to include(@facet_configuration_two)
    end
  end

  describe "#search_configs" do

    before(:all) do
      @search_configuration_one = BlacklightConfiguration.new(configuration: "search", label:  "Title", solr_field: "title_tsim", enabled: true)
    end

    it "will return the title configuration from the list" do
      blacklight_config_list.configuration_list << @search_configuration_one
      expect(blacklight_config_list.search_configs).to include(@search_configuration_one)
    end
  end

  describe "#sort_configs" do

    before(:all) do
      @sort_configuration_one = BlacklightConfiguration.new(configuration: "sort", label:  "Title", solr_field: "title_ssort", enabled: true)
      @sort_configuration_two = BlacklightConfiguration.new(configuration: "sort", label:  "Sort", solr_field: "price_ssort", enabled: true)
    end

    it "will return the title configuration from the list" do
      blacklight_config_list.configuration_list << @sort_configuration_one
      blacklight_config_list.configuration_list << @sort_configuration_two

      expect(blacklight_config_list.sort_configs).to include(@sort_configuration_one)
      expect(blacklight_config_list.sort_configs).to include(@sort_configuration_two)
    end
  end


  describe "#field_configuration" do
    before(:each) do
      test_config = BlacklightConfigurationTestClass.new
      blacklight_conf = test_config.blacklight_config

      # Add some test configs into list... 
      blacklight_config_list.configuration_list << BlacklightConfiguration.new(configuration: "title", label:  "", solr_field: "title_tsim", enabled: true)
      blacklight_config_list.configuration_list << BlacklightConfiguration.new(configuration: "index", label:  "Title", solr_field: "title_tsim", enabled: true)
      # Not enabled... we don't expect it
      blacklight_config_list.configuration_list << BlacklightConfiguration.new(configuration: "index", label:  "Sub-title", solr_field: "sub_title_tsim", enabled: false)
      blacklight_config_list.configuration_list << BlacklightConfiguration.new(configuration: "show", label:  "Description", solr_field: "description_tsim", enabled: true)
      blacklight_config_list.configuration_list << BlacklightConfiguration.new(configuration: "facet", label:  "Make", solr_field: "facet_field", enabled: true)
      blacklight_config_list.configuration_list << BlacklightConfiguration.new(configuration: "facet", label:  "Class", solr_field: "facet_field_two", enabled: true) 
      blacklight_config_list.configuration_list << BlacklightConfiguration.new(configuration: "search", label:  "Title", solr_field: "title_tsim", enabled: true)
      blacklight_config_list.configuration_list << BlacklightConfiguration.new(configuration: "sort", label:  "Title", solr_field: "title_ssort", enabled: true)
      # Not enabled... we don't expect it
      blacklight_config_list.configuration_list << BlacklightConfiguration.new(configuration: "sort", label:  "Author Sort", solr_field: "author_ssort", enabled: false)
      blacklight_config_list.configuration_list << BlacklightConfiguration.new(configuration: "sort", label:  "Sort", solr_field: "price_ssort", enabled: true)
    end
   
    it "will return an instantiated Blacklight::FieldConfiguration object with the expected configs" do
      field_config = blacklight_config_list.field_configuration
      expect(field_config.title).to eq "title_tsim"
      expect(field_config.index).to eq({ "Title" => "title_tsim" } )
      expect(field_config.show).to eq({ "Description" => "description_tsim" })
      expect(field_config.facet).to eq({ "Make" => "facet_field", "Class" => "facet_field_two" })
      expect(field_config.search).to eq({ "Title" => "title_tsim" })
      expect(field_config.sort).to eq({ "Title" => "title_ssort", "Sort" => "price_ssort"})
    end

  end


end
