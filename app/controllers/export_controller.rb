class ExportController < ApplicationController
	def index
		@students = Student.order('name ASC')
	  	respond_to do |format|
	    	format.html
	    	format.xlsx
		end
	end
end
