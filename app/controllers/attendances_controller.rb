class AttendancesController < ApplicationController

	def index

	end

	def show
		if session[:attended] == 'true'
			clear_cookies
		end
		@event = Event.find(params[:id])
		@student = Student.find_by(email: session[:email]) ? Student.find_by(email: session[:email]) :
																														 Student.new(email: session[:email])
	end

	def clear_cookies
		session[:email] = nil
		session[:updated] = nil
		session[:attended] = nil
	end

	def create
		session[:attended] = 'true'
		attendance = Attendance.new(attendance_params)
		attendance.save
		redirect_to(:back)
	end

	def attendance_params
		params.permit(:movie_id, :student_id)
	end

end