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
  attr_accessible :body,:picture_id,:user_id

  belongs_to :picture, :touch => true
  belongs_to :user
  has_many :events, as: :eventable
  validates :body,
            :presence => true,
            :length => { :minimum => 3,
                         :maximum => 200 }
  def controller_name
    'comments'
  end
  paginates_per 5
  #test
  validates_presence_of :body,:picture_id,:user_id
end
