class EditStudentsController < ApplicationController

	def index
		@student= Student.all
	end

	def edit
		@student = Student.find(params[:id])
	end

	def find
	end

	def show
		@findStudent = params[:findingStudents][:name].to_s
		@student = Student.find_student(@findStudent)
	end

	def save
		@student = Student.find(params[:id])

		new_values = {
			name:               params[:student][:name],
			year: 				params[:student][:year],
			zip:  				params[:student][:zip],
			email:              params[:student][:email],
			email_confirmation: params[:student][:email_confirmation],
			school_id:          params[:student][:school_id]
		}

		@student.update_attributes!(new_values)

		flash[:notice] = "Student updated!"
		redirect_to "/edit_students"
	end

	def destroy
		@student = Student.find(params[:id])
		@student.delete
		flash[:alert] = "Student deleted."
	    redirect_to '/edit_students'
	end

end
