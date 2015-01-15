require 'spec_helper'

describe "dataset_header_props/show" do
  before(:each) do
    @dataset_header_prop = assign(:dataset_header_prop, stub_model(DatasetHeaderProp,
      :name => "Name",
      :index => false,
      :display => false,
      :facet => false,
      :multivalued => false,
      :dataset => nil
    ))
  end

  it "renders attributes in <p>", pending: true do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/false/)
    rendered.should match(/false/)
    rendered.should match(/false/)
    rendered.should match(/false/)
    rendered.should match(//)
  end
end
