class Category < ActiveRecord::Base

  attr_accessible :name
  has_many :picture_categories
  has_many :pictures,:through => :picture_categories
  validates :name,
            :presence => true
end
