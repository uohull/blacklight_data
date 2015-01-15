require 'spec_helper'

describe "data_files/edit" do
  before(:each) do
    @data_file = assign(:data_file, stub_model(DataFile,
      :name => "MyString",
      :dataset => "MyString",
      :file => "MyString"
    ))
  end

  it "renders the edit data_file form", pending: true do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", data_file_path(@data_file), "post" do
      assert_select "input#data_file_name[name=?]", "data_file[name]"
      assert_select "input#data_file_dataset[name=?]", "data_file[dataset]"
      assert_select "input#data_file_file[name=?]", "data_file[file]"
    end
  end
end
