module Hull
  module Data
    class DatasetSolrMappingsConfigurationMapper
      attr_accessor :dataset_solr_mappings

      def initialize(dataset_solr_mappings)
        self.dataset_solr_mappings = dataset_solr_mappings
      end

      # Builds an array of BlacklightConfiguration objects based upon the DatasetSolrMappings
      def get_blacklight_configurations

        blacklight_configurations = []

        title_field_defined = false

        self.dataset_solr_mappings.each do |mapping|

          dataset = mapping[:dataset_header_prop].dataset
          label = mapping[:dataset_header_prop].name

          mapping[:solr_mapping].each do |key, value|

            if value.include? :displayable              
              blacklight_configurations << BlacklightConfiguration.new(configuration: "index", label: label, solr_field: key, enabled: true, dataset: dataset )
              blacklight_configurations << BlacklightConfiguration.new(configuration: "show", label: label, solr_field: key, enabled: true, dataset: dataset )
              
              # We define a title field based on the first displayable solr_field - can be changed later..
              if !title_field_defined
                blacklight_configurations << BlacklightConfiguration.new(configuration: "title", label: label, solr_field: key, enabled: true, dataset: dataset)
                title_field_defined = true
              end
            end

            if value.include? :facetable
              blacklight_configurations << BlacklightConfiguration.new(configuration: "facet", label: label, solr_field: key, enabled: true, dataset: dataset )
            end

            if value.include? :searchable 
              blacklight_configurations << BlacklightConfiguration.new(configuration: "search", label: label, solr_field: key, enabled: true, dataset: dataset )
            end

            if value.include? :sortable
              blacklight_configurations << BlacklightConfiguration.new(configuration: "sort", label: label, solr_field: key, enabled: true, dataset: dataset )
            end 

          end
        end

        blacklight_configurations
      end 

    end
  end
end
