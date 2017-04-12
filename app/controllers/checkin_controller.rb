class CheckinController < ApplicationController


	def create
		@student = Student.new
		if !emails_match?
			flash[:danger] = "Emails must match"
 		elsif !is_a_valid_email?
 			flash[:danger] = "Must be valid email"
 		else
 			session[:email] = params[:student][:email]
 		end
 		redirect_to(:back)
	end

	def is_a_valid_email?
  	(params[:student][:email] =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i)
	end

	def emails_match?
		params[:student][:email] == params[:student][:email_confirmation]
	end

end