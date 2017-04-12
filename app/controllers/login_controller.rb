class LoginController < ApplicationController

	def create
		session[:user_id] = current_user.id
	end

	def destroy
		session[:user_id] = nil
		flash[:success] = "Logged out"
  	redirect_to root_path
	end
end
