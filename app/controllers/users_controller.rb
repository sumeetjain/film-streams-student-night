class UsersController < ApplicationController


	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def create
		@current_user = User.new(user_params)
	    if @current_user.save && @current_user.authenticate(params[:user][:password])
    	session[:user_id] = @current_user.id
    	flash[:success] = "Welcome to Film Streams Student Night!"
    	redirect_to events_index
	  else
	  	@current_user
	    	render 'new'
	  end
	end

	def user_params
		params.require(:user).permit(:name, :password_digest,
											:password_confirmation)
	end
end
