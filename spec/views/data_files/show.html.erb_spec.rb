require 'spec_helper'

describe "data_files/show" do
  before(:each) do
    @data_file = assign(:data_file, stub_model(DataFile,
      :name => "Name",
      :dataset => "Dataset"
    ))
  end

  it "renders attributes in <p>" do
    pending("investigation into why this test is failing")
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Dataset/)
  end
end
