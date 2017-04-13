class StudentsController < ApplicationController

	def create
		@student = Student.new(student_params)
  	if @student.save
      redirect_to "/attendances/show"	
    end
    render :show
  end

  def update
  	@student = Student.find(params[:id])
  	@student.update_attributes(student_params)
  	redirect_to "/attendances/show"
  end

  def show
    email = session[:info]["email"]
    @student = Student.find_by(email: email) || Student.new(email: email)
  end

	def student_params
		params.require(:student).permit(:email, :name, :school, :year, :zip, :referral)
	end

end