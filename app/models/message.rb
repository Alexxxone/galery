# == Schema Information
#
# Table name: messages
#
#  id          :integer          not null, primary key
#  text        :string(255)
#  sender_id   :integer
#  receiver_id :integer
#

class Message < ActiveRecord::Base

  attr_accessible :sender_id,:receiver_id,:text
  belongs_to :user

  #test
  validates_presence_of  :sender_id,:receiver_id,:text
end
