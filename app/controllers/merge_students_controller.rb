class MergeStudentsController < ApplicationController

	# Search page to find the student to be merged into another
	def index
		@change = Student.find(params[:id])
	end

	# Shows the results of the search and lets the user pick one.
	def show
		@student1 = Student.find(params[:id])
		@student2 = Student.find_student(params[:searchKeep][:name])
	end

	def update
		@student1 = Student.find(params[:format])
		@student2 = Student.find(params[:id])
		@student1.attendances.update_all(student_id: @student2.id)
		flash[:notice] = "Student updated!"
	end

	def destroy
		@student = Student.find(params[:id])
		@student.delete
		flash[:alert] = "Student deleted."
	    redirect_to '/merge_students_search'
	end

end