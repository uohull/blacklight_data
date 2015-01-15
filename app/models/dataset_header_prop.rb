class DatasetHeaderProp < ActiveRecord::Base
  belongs_to :dataset

  after_initialize do |dataset|
    defaults
  end

  # Default fields when nil..
  def defaults
    self.searchable  ||= false
    self.displayable ||= true
    self.facetable   ||= false
    self.multivalued ||= false
    self.sortable    ||= false
    self.data_type   ||= "string"
  end
  
end