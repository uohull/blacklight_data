class BlacklightConfigurator 
  
  def self.configure_blacklight
    new().configure_blacklight
  end 

  def configure_blacklight
    CatalogController.blacklight_config = blacklight_configuration_list.blacklight_configuration unless blacklight_configuration_list.nil? 
  end

  private

  def blacklight_configuration_list
    BlacklightConfigurationList.new(indexed_dataset.blacklight_configurations) unless indexed_dataset.nil? 
  end

  def indexed_dataset
    Dataset.find_by_indexed(true)
  end

end