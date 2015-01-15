require 'spec_helper'

describe DataFile do

  let(:file_path) { "spec/fixtures/data/cars.csv" }
  let(:test_file) { File.open file_path  }
  let(:data_file) { DataFile.new(name: "Test file", file: test_file ) }

  describe "#file_path" do
    it "should provide the file path of the DataFile" do
      # For now we're checking that the path includesthe filename
      expect(data_file.file_path).to end_with("cars.csv")
    end
  end

end
