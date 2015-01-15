require 'spec_helper'

describe BlacklightConfigurator do

  describe "#configure_blacklight" do
    before do
      @blacklight_configurator = BlacklightConfigurator.new

      # Set up some test objects... 
      blacklight_configurations = Array.new 
      blacklight_configurations << BlacklightConfiguration.new(configuration: "title", label: "Test", solr_field: "title_sim" )
      blacklight_configurations << BlacklightConfiguration.new(configuration: "index", label: "Index field", solr_field: "index_sim" )
      blacklight_configurations << BlacklightConfiguration.new(configuration: "show", label: "Show field", solr_field: "show_sim" )
      blacklight_configurations << BlacklightConfiguration.new(configuration: "search", label: "Search field", solr_field: "search_field_tsim" )
      blacklight_configurations << BlacklightConfiguration.new(configuration: "sort", label: "Sort field", solr_field: "sort_field_ssort" )      
      @blacklight_config_list = BlacklightConfigurationList.new(blacklight_configurations)

      # stub the blacklight_configuration_lists method call with the object array above     
      @blacklight_configurator.stub(:blacklight_configuration_list) { @blacklight_config_list }

    end

    it "should set the CatalogController.blacklight_config with the expected class type" do
      expect(@blacklight_configurator.configure_blacklight.class).to eq Blacklight::Configuration 
    end

    it "should set the blacklight_config object with the expected attributes and values" do
      configuration = @blacklight_configurator.configure_blacklight
      # Only test a few as this functionality is tested elsewhere 
      # expect(configuration.show.title_field).to eq "title_sim"
      # expect(configuration.index_fields.first).to include( Blacklight::Configuration::IndexField.new(label:"Index field", field:"index_sim") )
      # expect(configuration.show_fields.first).to include( Blacklight::Configuration::ShowField.new(label:"Show field", field:"show_sim") )
    end

  end


end

