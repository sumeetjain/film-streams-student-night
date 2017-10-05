class AdminStudentsController < ApplicationController

	def index
		# @student = Student.all
		if params[:findingStudents] != nil
			redirect_to "/admin_students/show?name=#{params[:findingStudents][:name]}"
		end
	end

	def edit
		@student = Student.find(params[:id])
	end

	def find
		redirect_to "admin_students/show"
	end

	def show
		@findStudent = params[:name].to_s
		@student = Student.find_student(@findStudent)
	end

	def update
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
		redirect_to "/admin_students"
	end

	def destroy
		@student = Student.find(params[:id])
		@student.delete
		flash[:alert] = "Student deleted."
	    redirect_to '/admin_students'
	end

end
