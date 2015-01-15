module Blacklight
  class FieldConfiguration
    attr_accessor :title, :index, :show, :facet, :search, :sort, :blacklight_config

    def add_field_configurations config
     @blacklight_config = config     
     return generate_field_configurations
    end

    def generate_field_configurations
     
      unless index.nil? 
       add_index_fields
      end

      unless show.nil?
       add_show_fields
      end

      unless facet.nil?
       add_facet_fields
      end

      unless title.nil?
       add_show_title_field
       add_index_title_field
      end

      unless search.nil?
       add_search_fields
      end

      unless sort.nil?
        add_sort_fields
      end

      return @blacklight_config
    end

    private 

    def add_show_title_field
      @blacklight_config.show.title_field = title
    end

    def add_index_title_field
      @blacklight_config.index.title_field = title
    end

    def add_index_fields
      index.each do |label, solr_fname|
        @blacklight_config.add_index_field solr_fname, label: label
      end  
    end

    def add_show_fields
      show.each do |label, solr_fname|
        @blacklight_config.add_show_field solr_fname,  label: label
      end
    end

    def add_facet_fields
      facet.each do |label, solr_fname|
        @blacklight_config.add_facet_field solr_fname, label: label
      end
    end

    def add_search_fields
      # Add search fields to all_search
      search_solr_fnames = search.values

      @blacklight_config.add_search_field('all_fields') do |field|
       field.solr_local_parameters = {
         qf: search_solr_fnames.join(" ")
       }       
      end

      # Add individual search handlers for search fields
      search.each do |label, solr_fname|
        # Add search field for  each 'search' attribute
        @blacklight_config.add_search_field(label) do |field|
          field.solr_local_parameters = {
            qf: solr_fname
          }
        end
      end

    end

    def add_sort_fields
      # Add the sort fields, with default addition of text to label
      sort.each do |label, solr_fname|
        @blacklight_config.add_sort_field(asc_sort_solr_field(solr_fname), label: asc_sort_field_label(label))
        @blacklight_config.add_sort_field(desc_sort_solr_field(solr_fname), label: desc_sort_field_label(label))
      end
    end


    %w(asc desc).each do |type|
      define_method("#{type}_sort_solr_field") do |argument| 
        "#{argument} #{type}"
      end
    end

    %w(asc desc).each do |type|
      define_method("#{type}_sort_field_label") do |argument|
        if type == "asc" 
          "#{argument} (ascending)"
        elsif type == "desc"
          "#{argument} (descending)"
        end
      end
    end

  end
end