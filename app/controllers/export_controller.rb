class ExportController < ApplicationController
	def index
		@students = Student.all
		@movies = Movie.all
		@referrals = Referral.all
	  	respond_to do |format|
	  		time = Time.new
	    	format.html
	    	format.xlsx{
	    		response.headers['Content-Disposition'] = 'attachment; filename="export_' + time.to_s + '.xlsx"'
	    	}
		end
	end
end
