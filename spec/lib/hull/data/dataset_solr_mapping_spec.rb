require "spec_helper"
require_relative "../../../../lib/hull/data/dataset_solr_mapping"

describe Hull::Data::DatasetSolrMapping do
  let(:dataset_header_prop) do
    double("DatasetHeaderProp", name: "Test Header 1",
                                searchable: true,
                                displayable: false,
                                facetable: true,
                                sortable: false,
                                multivalued: true,
                                type: "string")
  end

  let(:data_file) do 
    mock_model DataFile, name: "Sample data",
                         file_path: "spec/fixtures/shapes/sample_phenotypic_data.csv"
  end

  let(:dataset) do
    mock_model Dataset, data_file: data_file, dataset_header_props: []
  end

  let(:dataset_header_prop) do
    double("DatasetHeaderProp", name: "Test Header 1",
                              searchable: true,
                              displayable: true,
                              facetable: false,
                              sortable: false,
                              multivalued: true,
                              type: "string")
  end

  let(:dataset_header_prop_two) do
    double("DatasetHeaderProp", name: "Test Header 2",
                              searchable: false,
                              displayable: true,
                              facetable: true,
                              sortable: true,
                              multivalued: false,
                              type: "string")
    end

  #let(:dataset) { Dataset.new( data_file: data_file, dataset_header_props: [dataset_header_prop] ) } 
  
  describe "#initialize" do
    it "can set the dataset header" do
      dataset_solr_mapping = Hull::Data::DatasetSolrMapping.new(dataset)
      expect(dataset_solr_mapping.dataset).to eq dataset
    end
  end

  context "with a searchable, displayable, multivalued, string header" do

    before(:each) do
        dataset.dataset_header_props << dataset_header_prop
        dataset.dataset_header_props << dataset_header_prop_two
        
        # We are stubbing the method call to Hull::Solr::SolrFieldMapping.solr_field_mapping tested elsewhere...
        dataset_solr_mapping.stub(:header_props_solr_mapping).with(dataset_header_prop) { { "test_tsim" => [:searchable, :displayable, :multivalued]} }
        dataset_solr_mapping.stub(:header_props_solr_mapping).with(dataset_header_prop_two) { { "test_ts" => [:displayable, :multivalued], "test_si" => [:facetable], "test_ssort" => [:sortable]} }
    end

    let(:dataset_solr_mapping) { Hull::Data::DatasetSolrMapping.new(dataset) }
    
    describe "#get_solr_mappings" do     

      it "returns a hash of solr_field to property mappings" do       
        solr_mappings = dataset_solr_mapping.solr_mappings

        expect(solr_mappings.size).to eq 2 
        expect(solr_mappings.first).to eq({ dataset_header_prop: dataset_header_prop, solr_mapping:  { "test_tsim" => [:searchable, :displayable, :multivalued] }  })
        expect(solr_mappings.last).to eq({ dataset_header_prop: dataset_header_prop_two, solr_mapping: { "test_ts" => [:displayable, :multivalued], "test_si" => [:facetable], "test_ssort" => [:sortable]}  })
      end
      
    end

    describe "#searchable_fields" do 
      it "returns a hash array that represent the searchable fields" do
        searchable_fields = dataset_solr_mapping.searchable_fields
        expect(searchable_fields).to eq([ { dataset_header_prop: dataset_header_prop, solr_mapping: { "test_tsim" => [:searchable, :displayable, :multivalued] } }]) 
      end
    end

    describe "#displayable_fields" do
      it "returns a hash array that represents displayable fields" do
        displayable_fields = dataset_solr_mapping.displayable_fields
        expect(displayable_fields).to eq( [ { dataset_header_prop: dataset_header_prop, solr_mapping: { "test_tsim" => [:searchable, :displayable, :multivalued] } },
                                            { dataset_header_prop: dataset_header_prop_two, solr_mapping: { "test_ts" => [:displayable, :multivalued] } } ])
      end
    end

    describe "#facetable_fields" do
      it "returns a hash array that represents facetable fields" do
        facetable_fields = dataset_solr_mapping.facetable_fields
        expect(facetable_fields).to eq( [ { dataset_header_prop: dataset_header_prop_two, solr_mapping: { "test_si" => [:facetable] } } ])
      end
    end

    describe "#sortable_fields" do
      it "returns a hash array that represents sortable fields" do
        sortable_fields = dataset_solr_mapping.sortable_fields
        expect(sortable_fields).to eq( [ { dataset_header_prop: dataset_header_prop_two, solr_mapping: { "test_ssort" => [:sortable] } } ])
      end
    end

  end

end