# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'spec_helper'

describe Category do

  it {have_db_column(:id).of_type(:integer)}
  it {have_db_column(:name).of_type(:string)}
  it {have_db_column(:created_at).
      of_type(:datetime).
      with_options(:null => false)}
  it {have_db_column(:updated_at).
      of_type(:datetime).
      with_options(:null => false)}

  it { should allow_mass_assignment_of(:name) }

  it { should_not allow_mass_assignment_of(:created_at) }
  it { should_not allow_mass_assignment_of(:updated_at) }

  it { should have_many(:picture_categories)}
  it { should have_many(:pictures).through(:picture_categories)}
  it { should have_many(:user_categories)}
  it { should have_many(:users).through(:user_categories)}

  it { should validate_presence_of(:name)}

  context "check " do
    before :each do
     @cat =  FactoryGirl.create(:category)
     @cat.pictures << FactoryGirl.create(:picture)
    end

    it "create category" do
      Category.count.should == 1
      @cat.pictures.count.should == 1
    end
    it "should return right controller name" do
      expect(@cat.controller_name).to eq("categories")
    end

  end
end
