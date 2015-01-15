require 'spec_helper'

describe "blacklight_configurations/show" do
  before(:each) do
    @blacklight_configuration = assign(:blacklight_configuration, stub_model(BlacklightConfiguration,
      :configuration => "Configuration",
      :key => "Key",
      :value => "Value"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Configuration/)
    rendered.should match(/Key/)
    rendered.should match(/Value/)
  end
end
