class User < ActiveRecord::Base
  attr_accessor :password_confirmation

	validates :username, presence: true
	validates :password_digest, presence: true, length: { minimum: 6 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255},
										format: { with: VALID_EMAIL_REGEX }
end
