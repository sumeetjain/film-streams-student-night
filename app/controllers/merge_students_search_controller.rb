class MergeStudentsSearchController < ApplicationController
	def index
		if (params[:searchChange] != nil)
			redirect_to "/merge_students/show?change=#{params[:searchChange][:name]}"
		end
	end

	def edit
		@change = params[:change].to_s
		@student1 = Student.find_student(@change)
	end

end
