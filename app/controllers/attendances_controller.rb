class AttendancesController < ApplicationController

	def show
		@event = Event.find(session[:info]["event_id"])
		@student_id = Student.find_by(email: session[:info]["email"]).id
	end

	def create
		attendance = Attendance.new(attendance_params)
		attendance.save
		session[:info] = nil
		redirect_to "/checkin/show"
	end

	def attendance_params
		params.permit(:movie_id, :student_id)
	end

end