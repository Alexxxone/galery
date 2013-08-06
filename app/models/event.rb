# == Schema Information
#
# Table name: events
#
#  id             :integer          not null, primary key
#  eventable_id   :integer
#  eventable_type :string(255)
#  user_id        :integer
#  created_at     :datetime
#

class Event < ActiveRecord::Base

  attr_accessible :eventable_type, :eventable_id,:user_id, :eventable

  belongs_to :eventable, :polymorphic => true
  belongs_to :user

  #test
  validates_presence_of  :eventable_type, :eventable_id, :user_id, :eventable
end
