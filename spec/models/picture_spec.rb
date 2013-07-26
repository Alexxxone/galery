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
  #
  #has_many :comments,dependent: :destroy
  #has_many :picture_categories
  #has_many :categories,:through => :picture_categories
  #has_many :likes,dependent: :destroy
  it { should_not allow_mass_assignment_of(:created_at) }

  it { should_not allow_mass_assignment_of(:id) }
  it { should allow_mass_assignment_of(:title) }
  it { should allow_mass_assignment_of(:filename) }
  it { FactoryGirl.build(:picture).respond_to?( :category_ids ).should be_true}



  it { should have_many(:comments).dependent(:destroy)}
  it { should have_many(:likes).dependent(:destroy)}
  it { should have_many(:categories).through(:picture_categories) }



  context "scopes" do

    before :each do

       cat = FactoryGirl.create(:category)
       puts cat.inspect
       cat.pictures << FactoryGirl.create(:picture)
       puts cat.pictures.inspect


    end

    it "should validte filename presense" do

      Picture.count.should == 1
      Picture.filename.should be true
    end




    #
    #it "should return correct result for scope not_hidden" do
    #  Post.not_hidden.count == 3
    #end
    #
    #it "should return correct result for scope user_confirmed" do
    #  Post.user_confirmed.count == 1
    #  Post.user_confirmed.map{|post| post.title}.should ==  ["#post Name 1"]
    #end
    #
    #it "should return correct result for scope waiting_to_approve" do
    #  Post.waiting_to_approve.count == 2
    #  Post.waiting_to_approve.map{|post| post.title}.should == ["#post Name 0", "blabla hidden"]
    #end
    #
    #it "should return correct result for scope user_confirmed" do
    #  Post.waiting_warning.count == 1
    #  Post.waiting_warning.map{|post| post.title}.should ==  ["#post Name 2"]
    #end

  end
end

