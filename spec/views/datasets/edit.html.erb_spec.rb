require 'spec_helper'

describe "datasets/edit" do
  before(:each) do
    @dataset = assign(:dataset, stub_model(Dataset,
      :data_file => "MyString"
    ))
  end

  it "renders the edit dataset form", pending: true do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", dataset_path(@dataset), "post" do
      assert_select "input#dataset_data_file[name=?]", "dataset[data_file]"
    end
  end
end
