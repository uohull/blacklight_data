require_relative '../../../../lib/hull/data/csv_solrizer'

describe Hull::Data::CsvSolrizer do

  let(:solr_conection) { }

  let(:file_path) { File.join("spec", "fixtures", "data", "cars.csv") }
  let(:csv)  { CSV.read(file_path, { headers: true }) }
  let(:csv_row) { csv.first }

#Make,Model,Engine Size (CC),Fuel Type,Price,Year

  let(:dataset_header_prop_make)   { double("DatasetHeaderProp", name: "Make") }
  let(:dataset_header_prop_model)  { double("DatasetHeaderProp", name: "Model") }
  let(:dataset_header_prop_engine) { double("DatasetHeaderProp", name: "Engine Size (CC)") }
  let(:dataset_header_prop_fuel)   { double("DatasetHeaderProp", name: "Fuel Type") }
  let(:dataset_header_prop_price)  { double("DatasetHeaderProp", name: "Price") }
  let(:dataset_header_prop_year)  { double("DatasetHeaderProp", name: "Year") }


  let(:solr_mappings) {
    [ { dataset_header_prop: dataset_header_prop_make, solr_mapping: { "make_tsi" => [:indexed, :displayable], "make_si" => [:facetable], "make_ssort" => [:sortable] } },
      { dataset_header_prop: dataset_header_prop_model, solr_mapping: { "model_tsi" =>  [:indexed, :displayable] } },
      { dataset_header_prop: dataset_header_prop_engine, solr_mapping: { "engine_size_cc_ts" => [:displayable] } },
      { dataset_header_prop: dataset_header_prop_fuel, solr_mapping: { "fuel_tsi" => [:indexed, :displayable] } },
      { dataset_header_prop: dataset_header_prop_price, solr_mapping: { "price_ts" => [:displayable], "price_ssort" => [:sortable] } },
      { dataset_header_prop: dataset_header_prop_year, solr_mapping: { "year_ts" => [:displayable], "year_ssort" => [:sortable] } },
       ]
  }

  describe "#index_csv" do
    it "indexes csv based upon solrfield mappings, and returns boolean on success" do

      # Mock the Solr connection returns (so we don't need solr running to test)
      solr_connection = double()
      allow(solr_connection).to receive(:add) { {"responseHeader"=>{"status"=>0, "QTime"=>8}} }
      allow(solr_connection).to receive(:commit) {  {"responseHeader"=>{"status"=>0, "QTime"=>61}} }

      success, message = Hull::Data::CsvSolrizer.index_csv(csv, solr_mappings, solr_connection)      
      expect(success).to be_true
      expect(message).to eq ""

    end
  end

  describe "#build_solr_doc" do
    it "returns a solr document for a instance of CSV::Row and Solr Field Mapping" do
      solr_doc = Hull::Data::CsvSolrizer.build_solr_doc("1", csv_row, solr_mappings )

      expect(solr_doc).to include( "id" => "1",
                                   "make_tsi" => "Vauxhall",
                                   "make_si"  => "Vauxhall",
                                   "make_ssort" => "Vauxhall",
                                   "model_tsi" => "Cavalier",
                                   "engine_size_cc_ts" => "1598",
                                   "fuel_tsi" => "Petrol",
                                   "price_ts" => "434",
                                   "price_ssort" => "434", 
                                   "year_ts"=>"1990",
                                    "year_ssort"=>"1990" )
   end

  end

end
