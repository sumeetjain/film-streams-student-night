class MergeStudentsController < ApplicationController

	def index
		@attend = Student.all.limit(30)

		if (params[:studentMerge] != nil)
			redirect_to "/merge_students/show?change=#{params[:studentMerge][:firstStudent]}&keep=#{params[:studentMerge][:secondStudent]}"
		end
	end

	def show
		@keep = params[:keep]
		@change = params[:change]
		@student1 = Student.find(params[:change])
		@student2 = Student.find(params[:keep])
	end

	def edit
		@student1 = Student.find(params[:attend])
		@student2 = Student.find(params[:id])
		@student2.attendances = @student2.attendances.append(@student1.attendances)
	end

	def destroy
		@student = Student.find(params[:id])
		@student.delete
		flash[:alert] = "Student deleted."
	    redirect_to '/merge_students'
	end

end