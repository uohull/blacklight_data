require 'spec_helper'

describe "BlacklightConfigurations" do
  describe "GET /blacklight_configurations" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get blacklight_configurations_path
      response.status.should be(200)
    end
  end
end
