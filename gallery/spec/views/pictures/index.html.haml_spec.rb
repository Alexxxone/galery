require 'spec_helper'

describe "pictures/index" do
  before(:each) do
    assign(:pictures, [
      stub_model(Picture,
        :title => "Title",
        :string => "String",
        :data => "Data",
        :datatime => "Datatime"
      ),
      stub_model(Picture,
        :title => "Title",
        :string => "String",
        :data => "Data",
        :datatime => "Datatime"
      )
    ])
  end

  it "renders a list of pictures" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "String".to_s, :count => 2
    assert_select "tr>td", :text => "Data".to_s, :count => 2
    assert_select "tr>td", :text => "Datatime".to_s, :count => 2
  end
end
