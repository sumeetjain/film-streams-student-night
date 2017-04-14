class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  before_filter :load_current_user

  # Returns User object according to user who is logged in or assigns nil value 
  def load_current_user
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    end
  end

  helper_method :load_current_user
  
end
