class ExportController < ApplicationController
	def index
		@students = Student.all
		@movies = Movie.all
	  	respond_to do |format|
	    	format.html
	    	format.xlsx
		end
	end
end
