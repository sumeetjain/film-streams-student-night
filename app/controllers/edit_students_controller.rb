class EditStudentsController < ApplicationController

	def index
		# TODO: Remove the limit once you're done.
		# SELECT * FROM Student WHERE name LIKE 'A%'
		@student = Student.where("name LIKE 'A%'")
	end

	def edit
		@student = Student.find(params[:id])
	end

	def save
		@student = Student.find(params[:id])

		new_values = {
			name:               params[:student][:name],
			email:              params[:student][:email],
			email_confirmation: params[:student][:email_confirmation],
			school_id:          params[:student][:school_id]
		}

		@student.update_attributes!(new_values)

		flash[:notice] = "Student updated!"
		redirect_to "/merge"
	end

	def update
		@student = Student.find(params[:id])

		if @event.update_attributes(event_params)
			flash[:notice] = "Student updated!"
		else
			flash[:alert] = "Invalid Student Info"
		end

		redirect_to edit_students_path(@student.id)
	end
end
