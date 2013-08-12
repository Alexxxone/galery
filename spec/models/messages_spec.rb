# == Schema Information
#
# Table name: messages
#
#  id          :integer          not null, primary key
#  text        :string(255)
#  sender_id   :integer
#  receiver_id :integer
#


require 'spec_helper'

describe Message do

   it {should belong_to(:user)}

end
