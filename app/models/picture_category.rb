# == Schema Information
#
# Table name: picture_categories
#
#  id          :integer          not null, primary key
#  picture_id  :integer
#  category_id :integer
#

class PictureCategory < ActiveRecord::Base

  attr_accessible :picture_id, :category_id
  belongs_to :picture
  belongs_to :category


  #test
  validates_presence_of  :picture_id,:category_id
end
