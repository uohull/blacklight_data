module Hull
  module Solr
    class SolrFieldMapping
      attr_reader :data_fields

      # field_properties should be hash of { name: "Field name", type: "string", indexed: true, stored: true, multi_valued: false  }
      def self.solr_field_mapping field_properties
        solr_field_mappings = Hash.new

        name = field_properties[:name]
        type = field_properties[:type]
        searchable = field_properties[:searchable]
        sortable = field_properties[:sortable]
        facetable = field_properties[:facetable]
        displayable = field_properties[:displayable]
        multivalued = field_properties[:multivalued]

        solr_field_mappings.merge!(facet_field(name, multivalued)) if facetable
        solr_field_mappings.merge!(sort_field(name)) if sortable
        solr_field_mappings.merge!(field(name, "text" , displayable, searchable, multivalued)) if displayable || searchable

        return solr_field_mappings

      end

      def self.facet_field(field_name, multivalued)
        field = "#{field_name_prefix(field_name)}_#{field_name_suffix("string", false, true, multivalued)}"
        return { field => [:facetable] }
      end

      def self.sort_field(field_name)
        field = "#{field_name_prefix(field_name)}_ssort"
        return { field => [:sortable] }
      end

      def self.field(name, type, displayable, searchable, multivalued)
         field = "#{field_name_prefix(name)}_#{field_name_suffix(type, displayable, searchable, multivalued)}"
  
         props = Array.new
         props << :displayable if displayable
         props << :searchable if searchable
         props << :multivalued if multivalued

         return { field => props }
      end

      def self.field_name_prefix(field_name)
        field_name.downcase.gsub(/[^0-9a-z ]/i, '').gsub(" ", "_")
      end

      def self.field_name_suffix(type, stored, indexed, multi_valued)
        return "#{field_type_suffix(type)}#{stored_field_suffix(stored)}#{indexed_field_suffix(indexed)}#{multi_valued_field_suffix(multi_valued)}"
      end

      def self.field_type_suffix(type)
        case type.downcase 
        when "string"
          "s"
        when "boolean"
          "b"
        when "text"
          "t"
        when "integer"
          "i"
        when "float"
          "f"
        else
          "s"
        end
      end

      def self.indexed_field_suffix(indexed_field)
        indexed_field ? "i" : ""
      end

      def self.stored_field_suffix(stored_field)
        stored_field ? "s" : ""
      end

      def self.multi_valued_field_suffix(multi_valued_field)
        multi_valued_field ? "m" : ""
      end

    end
  end
end