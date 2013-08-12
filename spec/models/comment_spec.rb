# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  picture_id :integer
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Comment do

  it {have_db_column(:id).of_type(:integer)}
  it {have_db_column(:user_id).of_type(:integer)}
  it {have_db_column(:picture_id).of_type(:integer)}
  it {have_db_column(:body).of_type(:text)}
  it {have_db_column(:created_at).
      of_type(:datetime).
      with_options(:null => false)}
  it {have_db_column(:updated_at).
      of_type(:datetime).
      with_options(:null => false)}

  it { should belong_to(:show).touch(true) }
  it { should belong_to(:user) }

  it { should have_many(:events) }

  it { should_not allow_mass_assignment_of(:id) }

  it { should allow_mass_assignment_of(:body) }
  it { should allow_mass_assignment_of(:picture_id) }
  it { should allow_mass_assignment_of(:user_id) }
  it { should ensure_length_of(:body).
                  is_at_least(3).
                  is_at_most(200) }

  context "check" do
    before :each do
      @user = FactoryGirl.create(:user)
      @pic =  FactoryGirl.create(:show)
      @com =  FactoryGirl.create(:comment,:picture_id => @pic.id, :user_id => @user.id)

    end

    it "should validate presence" do
      Picture.count.should == 1
      User.count.should == 1
      Comment.count.should == 1
    end
    it "check creations" do
      @user.comments.count.should == 1
    end
    it "should have valid controller name method" do
      expect(@com.controller_name).to eq("comments")
    end

  end

end

