require 'spec_helper'

describe "datasets/index" do
  before(:each) do
    assign(:datasets, [
      stub_model(Dataset,
        :data_file => "Data File"
      ),
      stub_model(Dataset,
        :data_file => "Data File"
      )
    ])
  end

  it "renders a list of datasets", pending: true do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Data File".to_s, :count => 2
  end
end
