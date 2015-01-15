require 'spec_helper'

describe BlacklightConfiguration do

  let(:blacklight_config) { BlacklightConfiguration.new }

  describe "#configuration_types" do
    it "will return the correct list of configuration types" do
      expect(blacklight_config.configuration_types).to include({ "title" => "Title field", 
                                                                 "index" => "Index field",
                                                                 "show" => "Show field",
                                                                 "facet" => "Facet field",
                                                                 "search" => "Search field",
                                                                 "sort" => "Sort field" })
    end    
  end

end
