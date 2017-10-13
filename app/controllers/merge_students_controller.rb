class MergeStudentsController < ApplicationController

	#Search page to find the student to be merged into another
	def index
		@change = Student.find(params[:id])
	end

	#Shows the results of the search and lets the user pick one.
	def show
		@keep = params[:searchKeep][:name].to_s
		@student1 = Student.find(params[:id])
		@student2 = Student.find_student(@keep)
	end

	def edit
		@student1 = Student.find(params[:change])
		@student2 = Student.find(params[:id])
		@student2.update_attribute("attendances", Student.addAttend(@student2, @student1))
		flash[:notice] = "Student updated!"
	end

	def destroy
		@student = Student.find(params[:id])
		@student.delete
		flash[:alert] = "Student deleted."
	    redirect_to '/merge_students_search'
	end

end