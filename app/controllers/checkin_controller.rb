class CheckinController < ApplicationController


	def create
		@student = Student.new
		if !emails_match?
			flash[:danger] = "Emails must match"
 		elsif !is_a_valid_email?
 			flash[:danger] = "Must be valid email"
 		else
 			session[:email] = params[:student][:email]
 			# session[:event] = params[:id]
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



# class AttendancesController < ApplicationControllers

# 	def show
# 		@event = Event.find(params[:id])
# 		@student = Student.new
# 	end

# 	def create
# 		@student = Student.new
# 		if !emails_match?
# 			flash[:danger] = "Emails must match"
# 			redirect_to(:back)
#  		elsif !is_a_valid_email?
#  			flash[:danger] = "Must be valid email"
#  			redirect_to(:back)
#  		else
#  			@student = Student.find_by(email: params[:attendances][:email])
#  			@event = params[:id]
#  			render 'new'
#  		end
# 	end

# 	def student_params
# 		params.require(:attendances).permit(:email, :email_confirmation)
# 	end

# 	def is_a_valid_email?
#   	(params[:attendances][:email] =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i)
# 	end

# 	def emails_match?
# 		params[:attendances][:email] == params[:attendances][:email_confirmation]
# 	end
# end
