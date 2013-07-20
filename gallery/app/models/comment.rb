class Comment < ActiveRecord::Base
  attr_accessible :body,:image_id,:user_id

  belongs_to :picture, :touch => true
  belongs_to :user
  has_many :events, as: :eventable
end
