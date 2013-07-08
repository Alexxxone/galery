class Picture < ActiveRecord::Base

  attr_accessible :title,:filename,:category_ids
  mount_uploader :filename, ImageUploader

  has_many :comments
  has_many :picture_categories
  has_many :categories,:through => :picture_categories
  has_many :likes
  validates :filename,
            :presence => true

  validates :title,
            :presence => true,
            :length => { :minimum => 3,
                         :maximum => 45 }

  validates :categories,
            :presence => true
  paginates_per 5
end
