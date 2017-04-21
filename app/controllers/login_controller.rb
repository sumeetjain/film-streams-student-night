class LoginController < ApplicationController
	skip_before_filter :authenticate_user
	
	def index

	end

	def new

	end

  def create
	 user = User.find_by(email: params[:user][:email])
    if user && user.authenticate(params[:user][:password])
    	session[:user_id] = user.id
	    flash[:notice] = "Welcome to Film Streams Student Night!"
     	redirect_to events_url
    else
    	flash[:alert] = 'Wrong username or password'
    	redirect_to root_path
    end
  end

	def destroy
		session[:user_id] = nil
		flash[:notice] = "Logged out"
  	redirect_to root_path
	end
end
