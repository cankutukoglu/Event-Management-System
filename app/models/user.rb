class User < ApplicationRecord
  enum :user_type, { regular: 0, admin: 1 }
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :registrations, dependent: :destroy
  has_many :events, through: :registrations
  normalizes :email_address, with: ->(e) { e.strip.downcase }
  validates :user_type, :username, presence: true
end
