class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

    before_filter :load_current_user

  # Returns User object according to user who is logged in or assigns nil value 
  def load_current_user
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    else
      @current_user = User.new
    end
  end
end
