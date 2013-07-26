# == Schema Information
#
# Table name: urls
#
#  id  :integer          not null, primary key
#  url :string(255)
#

class Url < ActiveRecord::Base
  has_many :events, as: :eventable
end
