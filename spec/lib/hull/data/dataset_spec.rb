# require_relative '../../../../lib/hull/data/dataset'

# describe Hull::Data::Dataset do
#   let(:file_path) { File.join("spec", "fixtures", "shapes", "sample_phenotypic_data.csv") }
#   let(:dataset)  { Hull::Data::Dataset.new(file_path) }

#   describe "#intialize" do
#     it "stores a dataset file_path" do      
#       expect(dataset.file_path).to eq file_path     
#     end
#     it "generates a dataset data member" do      
#       expect(dataset.data).to_not be_nil     
#     end
#   end

#   describe "#parse_data" do 
#     it "return the data in CSV object" do 
#       expect(dataset.parse_data).to be_instance_of(CSV::Table)         
#     end
#   end

#   describe "#data_headers" do
#     it "returns a list of data columns in the dataset" do
#       expect(dataset.data_headers).to eq ["Family","Genus","Species / Subsp","Shape","Gram + / -","Motility","Flagellum","Temperature G (�C)","PH","oxygen","Isolated from / habitat","Spores","Size (�m)","GenBank AN (16SrRNA)"]
#     end
#   end

# end