class AttendancesController < ApplicationController

	def show
		@event = Event.find(session[:info]["event_id"])
	end

	def create
		attendance = Attendance.new(attendance_params)
		attendance.save
		redirect_to(:back)
	end

	def attendance_params
		params.permit(:movie_id, :student_id)
	end

end