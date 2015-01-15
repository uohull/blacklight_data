class BlacklightConfigurationList
  attr_accessor :configuration_list
  
  def initialize(configuration_list)
    self.configuration_list = configuration_list
  end

  def blacklight_configuration
    self.field_configuration.add_field_configurations(self.default_blacklight_configuration)
  end

  def default_blacklight_configuration
    config = Blacklight::Configuration.new

    config.blacklight_solr = RSolr.connect(Blacklight.solr_config)
    config.default_solr_params = {
      :qt => 'search',
      :rows => 10
    }
    config.add_field_configuration_to_solr_request!
    config.add_facet_fields_to_solr_request!
    config.spell_max = 5

    config
  end


  %w(title index show facet search sort).each do |type|
    define_method("#{type}_configs") do
      configs = Array.new
      self.configuration_list.each do |config|
         if config.enabled && config.configuration == type
           configs << config
         end 
      end
    
      return configs
    end
  end

  %w(index show facet search sort).each do |type|
    define_method("#{type}_hash") do
      hash = Hash.new
      configs = eval "self.#{type}_configs"

      unless configs.empty?
        configs.each do |conf|
          hash[conf.label] = conf.solr_field
        end
      end
      return hash

    end
  end


  def field_configuration
    field_configuration = Blacklight::FieldConfiguration.new

    unless self.title_configs.empty? 
      field_configuration.title = self.title_configs.first.solr_field 
    end

    field_configuration.index = self.index_hash
    field_configuration.show = self.show_hash
    field_configuration.facet = self.facet_hash
    field_configuration.search = self.search_hash
    field_configuration.sort = self.sort_hash

    return field_configuration   
  end


end
