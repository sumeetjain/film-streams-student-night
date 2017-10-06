class MergeStudentsController < ApplicationController

	def index
		@attend = Student.all.limit(30)
	end
end
