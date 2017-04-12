class StudentsController < ApplicationController

	def index
		@student = Student.new
	end

	def new
		@student = Student.new
	end

	def create
  		@student = Student.new(student_params)
	  	@student.save
	  	session[:updated] = true
  	  redirect_to(:back)
  end

  def update
  	@student = Student.find(params[:id])
  	@student.update_attributes(student_params)
  	session[:updated] = true
  	redirect_to(:back)
  end

	def student_params
		params.require(:student).permit(:email, :name, :school, :year, :zip, :referral)
	end

end


