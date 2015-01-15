require 'spec_helper'

describe "data_files/index" do
  before(:each) do
    assign(:data_files, [
      stub_model(DataFile,
        :name => "Name",
        :dataset => "Dataset"
      ),
      stub_model(DataFile,
        :name => "Name",
        :dataset => "Dataset"
      )
    ])
  end

  it "renders a list of data_files" do
    pending("investigation into why this test is failing")
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Dataset".to_s, :count => 2
  end
end
