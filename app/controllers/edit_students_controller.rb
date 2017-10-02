class EditStudentsController < ApplicationController

	def index
		@student = Student.order('name ASC')
	end

	def edit
		# @student1 = (student id FROM Student)
		# @student2 = (student id FROM Student)
		# @studentsMerge = [@student1, @student2]
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
