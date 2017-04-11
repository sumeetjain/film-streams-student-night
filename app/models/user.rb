class User < ActiveRecord::Base
	  attr_accessor :username, :password, :password_confirmation
end
