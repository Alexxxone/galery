# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  provider               :string(255)
#  uid                    :string(255)
#  name                   :string(255)
#  oauth_token            :string(255)
#  oauth_expires_at       :datetime
#  last_request_at        :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me ,:captcha, :captcha_key, :name, :provider, :uid

  has_many :messages
  has_many :comments,dependent: :destroy
  has_many :likes,dependent: :destroy
  has_many :user_categories
  has_many :categories,:through => :user_categories
  has_many :events,as: :eventable,dependent: :destroy

  accepts_nested_attributes_for :events
  apply_simple_captcha :message => "The secret Image and code were different"

  #RELATIONSHIPS
  has_many :senders, :class_name => "Message",
           :foreign_key => :sender_id

  has_many :receivers, :class_name => "Message",
           :foreign_key => :receiver_id

  #test
  validates_presence_of :email, :password, :password_confirmation,:remember_me
end

