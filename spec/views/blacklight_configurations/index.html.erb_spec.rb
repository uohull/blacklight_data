require 'spec_helper'

describe "blacklight_configurations/index" do
  before(:each) do
    assign(:blacklight_configurations, [
      stub_model(BlacklightConfiguration,
        :configuration => "Configuration",
        :key => "Key",
        :value => "Value"
      ),
      stub_model(BlacklightConfiguration,
        :configuration => "Configuration",
        :key => "Key",
        :value => "Value"
      )
    ])
  end

  it "renders a list of blacklight_configurations", pending: true do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Configuration".to_s, :count => 2
    assert_select "tr>td", :text => "Key".to_s, :count => 2
    assert_select "tr>td", :text => "Value".to_s, :count => 2
  end
end
