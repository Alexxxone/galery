class PictureCategory < ActiveRecord::Base

  attr_accessible :picture_id, :category_id
  belongs_to :picture
  belongs_to :category


end
