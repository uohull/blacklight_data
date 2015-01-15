require_relative '../solr/solr_field_mapping'

module Hull
  module Data
    class DatasetSolrMapping 
      attr_accessor :dataset

      def initialize(dataset)
        self.dataset = dataset
      end

      def solr_mappings
        mappings = []

        unless self.dataset.dataset_header_props.empty?
          self.dataset.dataset_header_props.each do |dataset_header_prop|
            header_mapping = header_props_solr_mapping(dataset_header_prop)
            mappings << Hash[:dataset_header_prop, dataset_header_prop, :solr_mapping, header_mapping ]
          end
        end

        mappings
      end

      # method used to retrieve searchable or displayable or... solr mapped fields from the Dataset
      %w(searchable displayable facetable sortable).each do |field_type|
        define_method("#{field_type}_fields") do
          solr_mappings.keep_if { |i| i[:solr_mapping].keep_if{ |key, val| val.include? field_type.to_sym }.size > 0 }
        end
      end

      private

      def header_props_solr_mapping(dataset_header_prop)
        field_props = { name: dataset_header_prop.name, type: "string", searchable: dataset_header_prop.searchable,
                        sortable: dataset_header_prop.sortable, facetable: dataset_header_prop.facetable, displayable: dataset_header_prop.displayable, 
                        multivalued: dataset_header_prop.multivalued }

        mapping = Hull::Solr::SolrFieldMapping.solr_field_mapping(field_props)      

        return mapping
      end

    end
  end
end