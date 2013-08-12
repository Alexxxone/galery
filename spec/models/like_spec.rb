# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  picture_id :integer
#

require 'spec_helper'

describe Like do

  #attr_accessible :user_id,:picture_id
  #belongs_to :picture
  #belongs_to :user
  #validates :user_id, :uniqueness => {:scope => :picture_id}
  #has_many :events, as: :eventable,dependent: :destroy

    it {have_db_column(:id).of_type(:integer)}
    it {have_db_column(:user_id).of_type(:integer)}
    it {have_db_column(:picture_id).of_type(:integer)}

    it { should allow_mass_assignment_of(:picture_id) }
    it { should allow_mass_assignment_of(:user_id) }
    it { should_not allow_mass_assignment_of(:id) }

    it { should validate_presence_of(:picture_id) }
    it { should validate_presence_of(:user_id) }

    it { should belong_to(:show) }
    it { should belong_to(:user) }
    it { should have_many(:events).dependent(:destroy)}
    it { should validate_uniqueness_of(:user_id).scoped_to(:picture_id) }

  context "check" do
    before :each do
      @pic = FactoryGirl.create(:show)
      @user = FactoryGirl.create(:user)
      FactoryGirl.create(:like, :picture_id => @pic.id, :user_id => @user.id)
    end

    it "correct like" do
     @pic.likes.count.should == 1
     @pic.likes.last.picture_id == @pic.id
     @pic.likes.last.user_id == @user.id
    end

  end
end