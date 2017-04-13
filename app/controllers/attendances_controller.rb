class AttendancesController < ApplicationController

	def show

		@event = Event.find(session[:info]["event_id"])
		@student_id = Student.find_by(email: session[:info]["email"]).id
	end

	def create
		Attendance.create(attendance_params)
		redirect_to "/checkin/#{session[:info]["event_id"]}"
	end

	def attendance_params
		params.permit(:movie_id, :student_id)
	end

end