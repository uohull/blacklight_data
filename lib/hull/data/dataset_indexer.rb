require_relative 'csv_solrizer'
require_relative 'dataset_solr_mapping'

module Hull
  module Data
    class DatasetIndexer

      def self.index(dataset)
        dataset_solr_mapping = Hull::Data::DatasetSolrMapping.new(dataset)        
        solr_mappings = dataset_solr_mapping.solr_mappings

        generate_blacklight_configurations(dataset, solr_mappings)

        success, message = Hull::Data::CsvSolrizer.index_csv(dataset.csv, solr_mappings, rsolr_connection )
      end

      private

      def self.generate_blacklight_configurations(dataset, solr_mappings)
        configuration_mapper = Hull::Data::DatasetSolrMappingsConfigurationMapper.new(solr_mappings)
        # get_blacklight_configurations returns a list of blacklight_configurations
        blacklight_configurations = configuration_mapper.get_blacklight_configurations
        
        unless blacklight_configurations.empty?
          # We remove the previous configurations because we re-generate the configs on a re-index...
          # Note: we may revise this, if we want persist blacklight configs for un-indexed datasets
          BlacklightConfiguration.delete_all

          # loop through the blacklight configurations and persist them
          blacklight_configurations.each do |config|
            config.save
          end
        end

      end

      def self.rsolr_connection
        RSolr.connect(Blacklight.solr_config)
      end

    end
  end
end