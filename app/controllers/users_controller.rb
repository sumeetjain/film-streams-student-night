class UsersController < ApplicationController
	def create
		@current_user = User.new(user_params)
	end

	def user_params
		params.require(:user).permit(:username, :password_digest,
											:password_confirmation)
	end
end
