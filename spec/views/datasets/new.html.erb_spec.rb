require 'spec_helper'

describe "datasets/new" do
  before(:each) do
    assign(:dataset, stub_model(Dataset,
      :data_file => "MyString"
    ).as_new_record)
  end

  it "renders new dataset form", pending: true do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", datasets_path, "post" do
      assert_select "input#dataset_data_file[name=?]", "dataset[data_file]"
    end
  end
end
