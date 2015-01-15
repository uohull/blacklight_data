require 'spec_helper'

describe "dataset_header_props/index" do
  before(:each) do
    assign(:dataset_header_props, [
      stub_model(DatasetHeaderProp,
        :name => "Name",
        :index => false,
        :display => false,
        :facet => false,
        :multivalued => false,
        :dataset => nil
      ),
      stub_model(DatasetHeaderProp,
        :name => "Name",
        :index => false,
        :display => false,
        :facet => false,
        :multivalued => false,
        :dataset => nil
      )
    ])
  end

  it "renders a list of dataset_header_props", pending: true do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 8
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
