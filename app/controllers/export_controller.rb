class ExportController < ApplicationController
	def index
		@students = Student.limit(2)
		@movies = Movie.limit(2)
	  	respond_to do |format|
	    	format.html
	    	format.xlsx
		end
	end
end
