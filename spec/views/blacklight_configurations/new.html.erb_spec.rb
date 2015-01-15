require 'spec_helper'

describe "blacklight_configurations/new" do
  before(:each) do
    assign(:blacklight_configuration, stub_model(BlacklightConfiguration,
      :configuration => "MyString",
      :key => "MyString",
      :value => "MyString"
    ).as_new_record)
  end

  it "renders new blacklight_configuration form", pending: true do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", blacklight_configurations_path, "post" do
      assert_select "input#blacklight_configuration_configuration[name=?]", "blacklight_configuration[configuration]"
      assert_select "input#blacklight_configuration_key[name=?]", "blacklight_configuration[key]"
      assert_select "input#blacklight_configuration_value[name=?]", "blacklight_configuration[value]"
    end
  end
end
