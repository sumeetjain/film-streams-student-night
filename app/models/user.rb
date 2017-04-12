class User < ActiveRecord::Base
  attr_accessor :password_confirmation

	validates :username, presence: true
	validates :password_digest, presence: true, length: { minimum: 6 }
end
