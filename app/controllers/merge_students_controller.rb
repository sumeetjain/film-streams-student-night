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
end

# What I need to do...
# 	Have two drop down menus. Select one from each. 
# 	First drop down is the one you want to merge(and delete)
# 	Second drop down is the one you want the information saved to.

# 	Take the "attendance.count" from the first and add it to the "attendance.count" for the second.
# 	Delete the first choice.
