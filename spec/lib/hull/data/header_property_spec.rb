require_relative '../../../../lib/hull/data/header_property'

describe Hull::Data::HeaderProperty do

  let(:header_property) {Hull::Data::HeaderProperty.new({ name: "Family", searchable: true, displayable: true, multivalued: true })}

  describe "#intialize" do
    it "stores the header name" do
      expect(header_property.name).to eq "Family"
    end

    it "stores the searchable boolean" do 
      expect(header_property.searchable).to eq true
    end
    
    it "stores the displayable boolean" do
      expect(header_property.displayable).to eq true    
    end

    it "stores the multivalued boolean" do
      expect(header_property.multivalued).to eq true
    end
  end

  describe "#to_hash" do
    it "returns a hash representation of the instance" do
      expect(header_property.to_hash).to include(name: "Family", searchable: true, displayable: true, multivalued: true)
    end
  end

end