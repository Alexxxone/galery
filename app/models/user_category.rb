# == Schema Information
#
# Table name: user_categories
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  category_id :integer
#

class UserCategory < ActiveRecord::Base

  attr_accessible :user_id, :category_id
  belongs_to :user
  belongs_to :category
  validates :user_id, :uniqueness => {:scope => :category_id}
  #test
  validates_presence_of :user_id, :category_id

end
