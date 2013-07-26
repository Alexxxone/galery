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

class Comment < ActiveRecord::Base
  attr_accessible :body,:image_id,:user_id

  belongs_to :picture, :touch => true
  belongs_to :user
  has_many :events, as: :eventable
  def controller_name
    'comments'
  end
  #test
  validates_presence_of :body,:image_id,:user_id
end
