require 'spec_helper'
require_relative '../../lib/hull/data/dataset_indexer'

describe Dataset do

  let(:data_file) do 
    mock_model DataFile, name: "Sample data",
                         file_path: "spec/fixtures/data/cars.csv"
  end

  let(:dataset) { Dataset.new( data_file: data_file ) } 

  let(:dataset_header_props_defaults) do
    ["Make","Model","Engine Size (CC)","Fuel Type","Price","Year"].map do |header|
      DatasetHeaderProp.new(name: header, dataset_id: nil)
    end
  end

  describe "#after_initialize" do
    it "sets a CSV instance of the data_file" do
      expect(dataset.csv).to be_instance_of(CSV::Table)
    end
    it "indexed defaults to false" do 
      expect(dataset.indexed).to be_false
    end
  end


  describe "#get_dataset_header_props" do
    it "returns pre-initialized dataset_header_props object instances" do
      expect(dataset.get_dataset_header_props.map { |prop| prop.name }).to match_array(dataset_header_props_defaults.map { |prop| prop.name })
    end
    
  end

  describe "#data_headers" do
    it "returns a list of data columns in the dataset" do
      expect(dataset.data_headers).to eq  ["Make","Model","Engine Size (CC)","Fuel Type","Price","Year"]
    end

    it "returns an empty array when a DataFile instance isn't set" do
      expect(Dataset.new().data_headers).to eq []
    end
  end

  describe "#index" do
    it "should index the Dataset according to the DatasetHeaderProps" do
      dataset.stub(:index_service) { [true, ""] }
      expect(dataset.indexed).to be_false
      success, message = dataset.index 
      expect(success).to be_true
      expect(message).to eq ""
      expect(dataset.indexed).to be_true
    end    
  end

end