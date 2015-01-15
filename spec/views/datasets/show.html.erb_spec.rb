require 'spec_helper'

describe "datasets/show" do
  before(:each) do
    @dataset = assign(:dataset, stub_model(Dataset,
      :data_file => "Data File"
    ))
  end

  it "renders attributes in <p>", pending: true do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Data File/)
  end
end
