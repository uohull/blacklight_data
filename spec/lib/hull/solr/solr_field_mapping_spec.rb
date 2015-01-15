require_relative '../../../../lib/hull/solr/solr_field_mapping'

describe Hull::Solr::SolrFieldMapping do

  let(:header_properties) {
    [{ name: "Family", indexed: true, stored: true, multi_valued: false },
     { name: "Shape", indexed: true, stored: true, multi_valued: true },
     { name: "PH", indexed: false, stored: true, multi_valued: false },
     { name: "size", indexed: true, stored: false, multi_valued: true }]
  }

  #let(:data_headers) { ["Family","Genus","Species / Subsp","Shape","Gram + / -","Motility","Flagellum","Temperature G (�C)","PH","oxygen","Isolated from / habitat","Spores","Size (�m)","GenBank AN (16SrRNA)"] }
  let(:solr_mapping) { Hull::Solr::SolrFieldMapping.new header_properties }


  describe "#solr_field_mapping" do
    let(:searchable_displayable_field) { { name: "Family", type: "string", searchable: true, displayable: true, facetable: false, sortable: false, multivalued: false } } 
    let(:searchable_displayable_facetable_sortable_multivalued_field) { { name: "Model", type: "string", searchable: true, displayable: true, facetable: true, sortable: true, multivalued: true } } 
    let(:displayable_facetable_field) { { name: "Title", type: "string", searchable: false, displayable: true, facetable: true, sortable: false, multivalued: false } } 
    let(:facetable_multivalued_field) { { name: "Type", type: "string", searchable: false, displayable: false, facetable: true, sortable: false, multivalued: true } } 


    it "returns a searchable, displayable solr field name in the expected format" do
      solr_field_mapping = Hull::Solr::SolrFieldMapping.solr_field_mapping(searchable_displayable_field)
      expect(solr_field_mapping).to include("family_tsi")
      expect(solr_field_mapping["family_tsi"]).to include(:searchable, :displayable)
    end

    it "returns a searchable, displayable, facetable, sortable solr field names in the expected format" do
      solr_field_mapping = Hull::Solr::SolrFieldMapping.solr_field_mapping(searchable_displayable_facetable_sortable_multivalued_field)
      expect(solr_field_mapping).to include("model_tsim", "model_ssort", "model_sim")
      expect(solr_field_mapping["model_tsim"]).to include(:searchable, :displayable)
      expect(solr_field_mapping["model_ssort"]).to include(:sortable)
      expect(solr_field_mapping["model_sim"]).to include(:facetable)
    end

    it "returns a displayable, facetable. multivalued solr field names in the expected format" do
      solr_field_mapping = Hull::Solr::SolrFieldMapping.solr_field_mapping(displayable_facetable_field)
      expect(solr_field_mapping).to include("title_ts", "title_si")
      expect(solr_field_mapping["title_ts"]).to include(:displayable)
      expect(solr_field_mapping["title_si"]).to include(:facetable)
    end

    it "returns a facetable solr field name in the expected format"  do
      solr_field_mapping = Hull::Solr::SolrFieldMapping.solr_field_mapping(facetable_multivalued_field)
      expect(solr_field_mapping).to include("type_sim")
      expect(solr_field_mapping["type_sim"]).to include(:facetable)
    end

  end

  describe "#field_name_suffix" do
    it "returns the correct solr suffix for a searchable, displayable and multivalued string field" do
      field_name_suffix = Hull::Solr::SolrFieldMapping.field_name_suffix("string", true, true, true)
      expect(field_name_suffix).to eq "ssim"
    end
 
    it "returns the correct solr suffix for a searchable, non-displayable non-multivalued string field" do
      field_name_suffix = Hull::Solr::SolrFieldMapping.field_name_suffix("string", false, true, false)
      expect(field_name_suffix).to eq "si"
    end

    it "returns the correct solr suffix for a non-searchable, displayable non-multivalued text field" do
      field_name_suffix = Hull::Solr::SolrFieldMapping.field_name_suffix("text", true, false, false)
      expect(field_name_suffix).to eq "ts"
    end

    it "returns the correct solr suffix for a searchable, displayable non-multivalued text field" do
      field_name_suffix = Hull::Solr::SolrFieldMapping.field_name_suffix("text", true, true, false)
      expect(field_name_suffix).to eq "tsi"
    end

  end


  describe "#field_name_prefix" do

    it "returns a solr field name based upon a simple header name" do
      field_name_prefix = Hull::Solr::SolrFieldMapping.field_name_prefix("Family")
      expect(field_name_prefix).to eq "family"
    end

    it "returns a solr field name based upon a header name with spaces" do
      field_name_prefix = Hull::Solr::SolrFieldMapping.field_name_prefix("Temperature G")
      expect(field_name_prefix).to eq "temperature_g"
    end

    it "returns a solr field name based upon a header name with spaces and other chars" do
      field_name_prefix = Hull::Solr::SolrFieldMapping.field_name_prefix("GenBank AN (16SrRNA)")
      expect(field_name_prefix).to eq "genbank_an_16srrna"
    end

  end

  describe "#solr_"

  describe "#field_type_suffix" do

    it "returns the correct suffix character for the string type" do
      type_suffix = Hull::Solr::SolrFieldMapping.field_type_suffix("string")
      expect(type_suffix).to eq "s"
    end

    it "returns the correct suffix character for the boolean type" do
      type_suffix = Hull::Solr::SolrFieldMapping.field_type_suffix("boolean")
      expect(type_suffix).to eq "b"
    end

    it "returns the correct suffix character for the text type" do
      type_suffix = Hull::Solr::SolrFieldMapping.field_type_suffix("text")
      expect(type_suffix).to eq "t"
    end

    it "returns the correct suffix character for the float type" do
      type_suffix = Hull::Solr::SolrFieldMapping.field_type_suffix("float")
      expect(type_suffix).to eq "f"
    end

    it "returns the correct suffix character for the integer type" do
      type_suffix = Hull::Solr::SolrFieldMapping.field_type_suffix("integer")
      expect(type_suffix).to eq "i"
    end

  end

  describe "#indexed_field_suffix" do 
    it "returns the correct suffix for non-searchable field" do 
      searchable_suffix = Hull::Solr::SolrFieldMapping.indexed_field_suffix(false)
      expect(searchable_suffix).to eq ""
    end

    it "returns the correct suffix for a searchable field" do 
      searchable_suffix = Hull::Solr::SolrFieldMapping.indexed_field_suffix(true)
      expect(searchable_suffix).to eq "i"
    end
  end

  describe "#stored_field_suffix" do
    it "returns the correct suffix for a non-displayable field" do 
      displayable_suffix = Hull::Solr::SolrFieldMapping.stored_field_suffix(false)
      expect(displayable_suffix).to eq ""
    end

    it "returns the correct suffix for a displayable field" do 
      displayable_suffix = Hull::Solr::SolrFieldMapping.stored_field_suffix(true)
      expect(displayable_suffix).to eq "s"
    end      
  end

  describe "#multi_valued_field_suffix" do
    it "returns the correct suffix for a non-multivalued field" do 
      multivalued_suffix = Hull::Solr::SolrFieldMapping.multi_valued_field_suffix(false)
      expect(multivalued_suffix).to eq ""
    end

    it "returns the correct suffix for a multi-valued field" do 
      multivalued_suffix = Hull::Solr::SolrFieldMapping.multi_valued_field_suffix(true)
      expect(multivalued_suffix).to eq "m"
    end      
  end

end