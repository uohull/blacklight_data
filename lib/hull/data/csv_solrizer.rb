require "csv"
require "rsolr"

module Hull
  module Data
    class CsvSolrizer

      def self.index_csv(csv, dataset_solr_mappings, solr_connection)
        begin
          csv.each_with_index do |csv_row, i|
            solr_doc = build_solr_doc(i, csv_row, dataset_solr_mappings)
            solr_connection.add solr_doc
          end

          solr_connection.commit

          return true, "" 

        rescue RSolr::Error::Http => error
          puts "An exception was thrown indexing csv into Solr. The full stack trace: #{error.to_s}"
          return false, "There was an issue indexing the CSV into Solr"

        end

      end

      def self.build_solr_doc(id, csv_row, dataset_solr_mappings)
        solr_doc = {"id" => id}
     
        dataset_solr_mappings.each do |dataset_solr_mapping|
          # Dataset header property stores name
          header_name = dataset_solr_mapping[:dataset_header_prop].name
          # The dataset_solr_mapping can have multiple solr_field_names mappings 
          solr_field_names = dataset_solr_mapping[:solr_mapping].keys
          value = csv_row[header_name]

          # Add the value to solr_fields
          solr_field_names.each { |solr_field_name| solr_doc[solr_field_name] = value }
        end

        return solr_doc

      end

    end

  end
end