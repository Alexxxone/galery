class Message < ActiveRecord::Base

  attr_accessible :sender_id,:receiver_id,:text
  belongs_to :user
end
