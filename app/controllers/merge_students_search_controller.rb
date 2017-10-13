class MergeStudentsSearchController < ApplicationController
	def index
	end

	def show
		@student1 = Student.find_student(params[:searchChange][:name])
	end

end
