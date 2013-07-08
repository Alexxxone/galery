class Like < ActiveRecord::Base

  attr_accessible :user_id,:picture_id
  belongs_to :picture
  belongs_to :user
  validates :user_id, :uniqueness => {:scope => :picture_id}
end
