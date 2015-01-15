require 'csv'

class Dataset < ActiveRecord::Base
  include ActiveModel::Validations

  attr_reader :csv

  belongs_to :data_file
  has_many :dataset_header_props, dependent: :destroy
  has_many :blacklight_configurations, dependent: :destroy 

  # Validates that indexed can only be set to true in one instance
  validates :indexed, uniqueness: true, unless: Proc.new { |dataset| dataset.indexed == false } 
  validates_with DatasetValidator

  after_initialize do |dataset|
    load_dataset
    defaults
  end
  
  def data_headers
    headers
  end

  def load_dataset
    unless data_file.nil?
      parse_data(data_file.file_path)
    end
  end

  # Use this method to get dataset_header_props members
  # This method will call generate_dataset_header_props if they do not exist
  def get_dataset_header_props
    self.dataset_header_props.empty? ? self.generate_dataset_header_props : self.dataset_header_props
  end

  def generate_dataset_header_props
    header_properties = []

    data_headers.each do |header|
      header_properties << DatasetHeaderProp.create( name: header, dataset: self )
    end

    return header_properties 
  end

  def index
    success, message = index_service

    if success
      set_as_indexed
      self.save
    end

    return success, message
  end

  def defaults
   # default indexed value
   self.indexed = false if (self.has_attribute? :indexed) && (self.indexed.nil?)
  end

  def content_type
    self.data_file.nil? ? "" : self.data_file.content_type
  end

  def valid_content_types
    self.class.valid_content_types
  end

  def self.valid_content_types
    %w(text/csv)
  end

  
  private

  def index_service
    Hull::Data::DatasetIndexer.index(self)
  end

  def set_as_indexed
    # First we need to check that others are not indexed... 
    dataset = Dataset.find_by_indexed(true)

    unless dataset.nil? || (self == dataset)
      dataset.indexed = false
      dataset.save
    end

    self.indexed = true 
  end

  def parse_data(file_path)
    @csv = CSV.read(file_path, { headers: true })
  end

  def headers 
    @csv.nil? ? [] : @csv.headers
  end

end