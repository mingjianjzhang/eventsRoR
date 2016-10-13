class User < ActiveRecord::Base
  has_secure_password
  has_many :comments
  has_many :owned_events, :class_name => "Event", :foreign_key => :owner_id, dependent: :destroy
  has_many :event_users, dependent: :destroy
  has_many :joined_events, through: :event_users, source: :event
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, :city, :state, presence: true, length:  { minimum: 2 }
  validates :email, presence: true, format: { with: EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 8 }, on: :create
  validates :password_confirmation, presence: true, on: :create
end
 
