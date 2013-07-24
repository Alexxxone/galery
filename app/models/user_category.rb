class UserCategory < ActiveRecord::Base

  attr_accessible :user_id, :category_id
  belongs_to :user
  belongs_to :category
  validates :user_id, :uniqueness => {:scope => :category_id}
end
