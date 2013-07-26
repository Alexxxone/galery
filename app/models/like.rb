# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  picture_id :integer
#

class Like < ActiveRecord::Base

  attr_accessible :user_id,:picture_id
  belongs_to :picture
  belongs_to :user
  validates :user_id, :uniqueness => {:scope => :picture_id}
  has_many :events, as: :eventable,dependent: :destroy

  #test
  validates_presence_of  :user_id,:picture_id
end
