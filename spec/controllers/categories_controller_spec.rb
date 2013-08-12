require 'spec_helper'


describe CategoriesController do

   context "SUBSCRIBE AND CHECK_SUBSCRIBE action" do
     before :each do
       @cat = FactoryGirl.create(:category)
       @cat2 = FactoryGirl.create(:category)
       @user = FactoryGirl.create(:user)
       sign_in @user
       @user_cat = FactoryGirl.create(:user_category,:category_id => @cat.id, :user_id => @user.id)
       @ano_pic = FactoryGirl.create(:another_picture)
       @pic = FactoryGirl.create(:show)

     end
     it "current user check likes for current picture with exist like" do
       post :subscribe
       Category.count.should == 2
       UserCategory.count.should == 1
       @user.categories.count.should == 1
     end
     it "current user unsubscribe category and subscribe to another" do
       post :subscribe,:cat_id => @cat.id
       @user.categories.count.should == 0
       FactoryGirl.create(:user_category,:category_id => @cat2.id, :user_id => @user.id)
       @user.categories.last.id.should == @cat2.id
       @user.categories.count.should == 1
     end
     it "not logged user try to subscribe to category" do
       sign_out @user
       post :subscribe,:cat_id => @cat.id
       response.should redirect_to(new_user_session_path)
     end

   end
end
