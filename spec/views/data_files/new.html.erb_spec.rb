require 'spec_helper'

describe "data_files/new" do
  before(:each) do
    assign(:data_file, stub_model(DataFile,
      :name => "MyString",
      :dataset => "MyString"
    ).as_new_record)
  end

  it "renders new data_file form" , pending: true do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", data_files_path, "post" do
      assert_select "input#data_file_name[name=?]", "data_file[name]"
      assert_select "input#data_file_dataset[name=?]", "data_file[dataset]"
    end
  end
end
