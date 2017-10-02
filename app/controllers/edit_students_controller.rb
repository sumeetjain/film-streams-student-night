class EditStudentsController < ApplicationController

	def index
		# TODO: Remove the limit once you're done.
		@student = Student.order('name ASC').limit(30)
	end

	def edit
		@student = Student.find(3)
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
