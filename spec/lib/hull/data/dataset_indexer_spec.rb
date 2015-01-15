require 'spec_helper'
require 'csv'

require_relative '../../../../lib/hull/data/dataset_indexer'

describe Hull::Data::DatasetIndexer do

  describe "#index" do

    let(:file_path) { File.join("spec", "fixtures", "data", "cars.csv") }
    let(:csv)  { CSV.read(file_path, { headers: true }) }

    let(:dataset_header_props) do

      ["Make","Model","Engine Size (CC)","Fuel Type","Price","Year"].map do |header|
        DatasetHeaderProp.new(name: header, dataset_id: nil)
      end
    end

    let(:dataset) do
      double("Dataset", csv: csv, dataset_header_props: dataset_header_props)
    end

    it "will index a Dataset instance" do
      Hull::Data::CsvSolrizer.should_receive(:index_csv) { [true, ""] }


      success, message = Hull::Data::DatasetIndexer.index(dataset)
      expect(success).to be_true
      expect(message).to eq ""
    end

  end

end
