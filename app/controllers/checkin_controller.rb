class CheckinController < ApplicationController

	def show
		@student = Student.new
	end

	def create
		if Validate.new(params[:student]).validation
			session[:info] = Sessions.new(params)
		  redirect_to "/students/show"
 		else
 			flash[:danger] = "Emails must match and be valid."
 			redirect_to(:back)
 		end
	end

end