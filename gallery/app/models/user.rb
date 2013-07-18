class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me ,:captcha, :captcha_key,:name, :provider, :uid, :provider
  # attr_accessible :title, :body
  has_many :comments
  has_many :likes
  has_many :user_categories
  has_many :categories,:through => :user_categories
  has_many :events,as: :eventable
  accepts_nested_attributes_for :events
  apply_simple_captcha :message => "The secret Image and code were different"

  attr_accessor :current_sign_in_at, :like_time, :cancel_like_time, :comment_time

end

