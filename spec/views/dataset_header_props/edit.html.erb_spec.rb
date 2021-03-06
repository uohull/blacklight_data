require 'spec_helper'

describe "dataset_header_props/edit" do
  before(:each) do
    @dataset_header_prop = assign(:dataset_header_prop, stub_model(DatasetHeaderProp,
      :name => "MyString",
      :index => false,
      :display => false,
      :facet => false,
      :multivalued => false,
      :dataset => nil
    ))
  end

  it "renders the edit dataset_header_prop form" , pending: true do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", dataset_header_prop_path(@dataset_header_prop), "post" do
      assert_select "input#dataset_header_prop_name[name=?]", "dataset_header_prop[name]"
      assert_select "input#dataset_header_prop_index[name=?]", "dataset_header_prop[index]"
      assert_select "input#dataset_header_prop_display[name=?]", "dataset_header_prop[display]"
      assert_select "input#dataset_header_prop_facet[name=?]", "dataset_header_prop[facet]"
      assert_select "input#dataset_header_prop_multivalued[name=?]", "dataset_header_prop[multivalued]"
      assert_select "input#dataset_header_prop_dataset[name=?]", "dataset_header_prop[dataset]"
    end
  end
end
