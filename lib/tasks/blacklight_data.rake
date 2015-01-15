require_relative '../blacklight/field_configuration'

namespace :blacklight_data do

  desc "Delete sample data"
  task :delete_data  => :environment  do
    puts "Deleting all data from index..."
    rsolr_connection.delete_by_query '*:*', params: { :commit => true }
    puts "Data deleted."

    puts "Deleting data from Database"
    BlacklightConfiguration.delete_all
    DatasetHeaderProp.delete_all
    Dataset.delete_all
    DataFile.delete_all
  end

  desc "Refresh sample data"
  task :refresh_data  do
    Rake::Task["blacklight_data:delete_data"].invoke
    Rake::Task["blacklight_data:load_data"].invoke
  end

  desc "Load some sample data"
  task :load_data  => :environment do

    data_file = DataFile.create(name: "Cars", file: File.open(sample_data))
    car_dataset = Dataset.create(data_file: data_file)

    car_dataset_header_props = car_dataset.get_dataset_header_props 

  
    car_dataset_header_props.each do | car_dataset_header|

      if car_dataset_header.name == "Make"
        car_dataset_header.searchable = true
        car_dataset_header.displayable = true
        car_dataset_header.facetable = true
        car_dataset_header.multivalued = false
        car_dataset_header.sortable = true
        car_dataset_header.data_type = "string"
      end

      if car_dataset_header.name == "Model"
        car_dataset_header.searchable = true
        car_dataset_header.displayable = true
        car_dataset_header.facetable = false
        car_dataset_header.multivalued = false
        car_dataset_header.sortable = true
        car_dataset_header.data_type = "string"
      end

      if car_dataset_header.name == "Engine Size (CC)"
        car_dataset_header.searchable = true
        car_dataset_header.displayable = true
        car_dataset_header.facetable = true
        car_dataset_header.multivalued = false
        car_dataset_header.sortable = false
        car_dataset_header.data_type = "string"   
      end

      if car_dataset_header.name == "Fuel Type"
        car_dataset_header.searchable = false
        car_dataset_header.displayable = true
        car_dataset_header.facetable = true
        car_dataset_header.multivalued = false
        car_dataset_header.sortable = false
        car_dataset_header.data_type = "string"
      end

      if car_dataset_header.name == "price"
        car_dataset_header.searchable = false
        car_dataset_header.displayable = true
        car_dataset_header.facetable = false
        car_dataset_header.multivalued = false
        car_dataset_header.sortable = true
        car_dataset_header.data_type = "string"
      end

      car_dataset_header.save
    end 

    car_dataset.index  

  end

end

def file_contents(path)
  file = File.open(path, "rb")
  file.read
end

def rsolr_connection
  RSolr.connect(Blacklight.solr_config)
end

def sample_data
  "./spec/fixtures/data/cars.csv"
end
