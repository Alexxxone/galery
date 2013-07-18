class Url < ActiveRecord::Base
  has_many :events, as: :eventable
end