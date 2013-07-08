require 'spec_helper'

describe "pictures/show" do
  before(:each) do
    @picture = assign(:picture, stub_model(Picture,
      :title => "Title",
      :string => "String",
      :data => "Data",
      :datatime => "Datatime"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/String/)
    rendered.should match(/Data/)
    rendered.should match(/Datatime/)
  end
end
