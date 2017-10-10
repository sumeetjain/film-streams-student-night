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

		flash[:notice] = "Students Merged!"
		redirect_to "/merge_students"
	end
end

# What I need to do...
# 	Have two drop down menus. Select one from each. 
# 	First drop down is the one you want to merge(and delete)
# 	Second drop down is the one you want the information saved to.

# 	Take the "attendance.count" from the first and add it to the "attendance.count" for the second.
# 	Delete the first choice.
