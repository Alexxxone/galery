class Category < ActiveRecord::Base

  attr_accessible :name
  has_many :picture_categories
  has_many :pictures,:through => :picture_categories
  has_many :user_categories
  has_many :users,:through => :user_categories
  validates :name,
            :presence => true

  def controller_name
    'categories'
  end
end
