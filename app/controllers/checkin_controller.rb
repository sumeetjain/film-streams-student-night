class CheckinController < ApplicationController


	def create
		@student = Student.new
		if !emails_match?
			flash.now[:danger] = "Emails must match"
			render template: "students/index"		
 		elsif !is_a_valid_email?
 			flash.now[:danager] = "Must be valid email"
 			render template: "students/index"		
 		elsif !exits?
 			@student = Student.new
 			@student.email = params[:student][:email]
 			render template: "students/new"
 		else
 			render template: "students/new"
 		end
	end

	def exits?
		@student = Student.find_by(email: params[:student][:email])
	end

	def student_params
		params.require(:student).permit(:email, :email_confirmation)
	end

	def is_a_valid_email?
  	(params[:student][:email] =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i)
	end

	def emails_match?
		params[:student][:email] == params[:student][:email_confirmation]
	end




end


# user = User.find_by(email: params[:user][:email])
#     if user && user.authenticate(params[:user][:password])
#     	session[:user_id] = user.id
# 	    flash[:success] = "Welcome!"
# 	    redirect_to '/user/show'
#     else
#     	flash[:danger] = 'Wrong username or password'
#     	redirect_to root_path
#     end
#   end