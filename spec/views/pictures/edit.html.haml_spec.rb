require 'spec_helper'

describe "pictures/edit" do
  before(:each) do
    @picture = assign(:show, stub_model(Picture,
      :title => "MyString",
      :string => "MyString",
      :data => "MyString",
      :datatime => "MyString"
    ))
  end

  it "renders the edit picture form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", picture_path(@picture), "post" do
      assert_select "input#picture_title[name=?]", "picture[title]"
      assert_select "input#picture_string[name=?]", "picture[string]"
      assert_select "input#picture_data[name=?]", "picture[data]"
      assert_select "input#picture_datatime[name=?]", "picture[datatime]"
    end
  end
end
