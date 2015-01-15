class BlacklightConfiguration < ActiveRecord::Base
  belongs_to :dataset
 
  def configuration_types
    configuration_types = Hash.new

    configuration_types["title"] = "Title field"
    configuration_types["index"] = "Index field"
    configuration_types["show"] = "Show field"
    configuration_types["facet"] = "Facet field"
    configuration_types["search"] = "Search field"
    configuration_types["sort"] = "Sort field"

    return configuration_types
  end

  # Methods to retrieve the different classes of configurations
  def self.title_configuration
    all.where(configuration: "title").first
  end

  def self.all_index_configurations
    all.where(configuration: "index")
  end

  def self.all_show_configurations
    all.where(configuration: "show")
  end

  def self.all_facet_configurations
    all.where(configuration: "facet")
  end

  def self.all_search_configurations
    all.where(configuration: "search")
  end

  def self.all_sort_configurations
    all.where(configuration: "sort")
  end

  def self.all_title_compatible_fields
    title_fields = {}
    # Show configs are 'displayable' in the backlight sense...
    show_configs = self.all_show_configurations
    show_configs.each { |config| title_fields[config.solr_field] = config.label }

    title_fields
  end

end
