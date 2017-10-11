class MergeStudentsController < ApplicationController

	#Search page to find the student to be merged into another
	def index
		if (params[:searchChange] != nil)
			redirect_to "/merge_students/show?change=#{params[:searchChange][:name]}"
		end
	end

	#Shows the results of the search and lets the user pick one.
	def show
		@change = params[:change].to_s
		@student1 = Student.find_student(@change)
	end

	#Gets passed in the selected student from 'show' and lets the user search for a second student
	def findSecond
		@change = Student.find(params[:id])
		if (params[:searchKeep] != nil)
			redirect_to "/merge_students/pickSecond?keep=#{params[:searchKeep][:name]}&change=#{@change.id}"
		end
	end

	# Shows search results from the second search
	# first student is passed in
	# passes both students to edit
	def pickSecond
		@keep = params[:keep].to_s
		@student1 = Student.find(params[:change])
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
	    redirect_to '/merge_students'
	end

end