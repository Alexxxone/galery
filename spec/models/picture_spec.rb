# == Schema Information
#
# Table name: pictures
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  filename   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Picture do

  it { should have_many(:comments).dependent(:destroy)}
  it { should have_many(:likes).dependent(:destroy)}
  it { should have_many(:picture_categories) }
  it { should have_many(:categories).through(:picture_categories) }

  it { should_not allow_mass_assignment_of(:created_at) }
  it { should_not allow_mass_assignment_of(:id) }

  it { should allow_mass_assignment_of(:title) }
  it { should allow_mass_assignment_of(:filename) }
  it { FactoryGirl.build(:picture).respond_to?( :category_ids ).should be_true}
  it { should ensure_length_of(:title).
                  is_at_least(3).
                  is_at_most(255) }

  context "scopes" do
    before :each do
      cat = FactoryGirl.create(:category)
      @pic =  FactoryGirl.create(:picture)
      cat.pictures <<  @pic
    end

    it "should validate filename presence" do
      Picture.count.should == 1
    end

    it "should have valid controller name method" do
      expect(@pic.controller_name).to eq("pictures")
    end

  end

end



