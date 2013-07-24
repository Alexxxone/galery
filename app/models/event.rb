class Event < ActiveRecord::Base
  belongs_to :eventable, :polymorphic => true
  attr_accessible :eventable_type,:eventable_id,:user_id,:eventable
  belongs_to :user

end