require 'spec_helper'

describe "blacklight_configurations/edit" do
  before(:each) do
    @blacklight_configuration = assign(:blacklight_configuration, stub_model(BlacklightConfiguration,
      :configuration => "MyString",
      :key => "MyString",
      :value => "MyString"
    ))
  end

  it "renders the edit blacklight_configuration form", pending: true do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", blacklight_configuration_path(@blacklight_configuration), "post" do
      assert_select "input#blacklight_configuration_configuration[name=?]", "blacklight_configuration[configuration]"
      assert_select "input#blacklight_configuration_key[name=?]", "blacklight_configuration[key]"
      assert_select "input#blacklight_configuration_value[name=?]", "blacklight_configuration[value]"
    end
  end
end
