class AttendancesController < ApplicationController

	def index

	end

	def show
		@event = Event.find(params[:id])
		@student = Student.find_by(email: session[:email]) ? Student.find_by(email: session[:email]) : Student.new
	end

	def create
	  session[:email] = nil
	  session[:updated] = nil
		redirect_to(:back)
	end
end