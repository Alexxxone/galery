# == Schema Information
#
# Table name: pictures
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  filename   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Picture < ActiveRecord::Base

  attr_accessible :title,:filename,:category_ids
  mount_uploader :filename, ImageUploader

  has_many :comments,dependent: :destroy
  has_many :picture_categories
  has_many :categories,:through => :picture_categories
  has_many :likes,dependent: :destroy

  validates :filename,
            :presence => true

  validates :title,
            :presence => true,
            :length => { :minimum => 3,
                         :maximum => 255 }
  paginates_per 5


  def controller_name
    'pictures'
  end
  #test
  validates_presence_of :title,:filename
end
