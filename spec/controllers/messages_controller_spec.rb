require 'spec_helper'


describe MessagesController do

  context "Message Controller" do
    before :each do
      @pic = FactoryGirl.create(:show)
      @user = FactoryGirl.create(:user,:email => 'one@mail.ru' ,:password => '12345678',:password_confirmation =>'12345678')
      @user2 = FactoryGirl.create(:user,:email => 'two@mail.ru' ,:password => '12345678',:password_confirmation =>'12345678')
    end

    it "asd" do
       FactoryGirl.create(:message, :sender_id => @user.id, :receiver_id => @user2.id )
       FactoryGirl.create(:message, :sender_id => @user2.id, :receiver_id => @user.id )
    end

  end
end
