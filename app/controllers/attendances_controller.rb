# Every action in this controller has params[:event_id].

class AttendancesController < ApplicationController

	def new
		# Use this to show the movies for this event.
		@event = Event.find(params[:event_id])
		@attendance = Attendance.new(event_id: @event.id, student_id: flash[:student_id])
		
	end

	# Save this student's attendance, and redirect to the event's
	# main page for the next student to check in.
	def create
		attendance = Attendance.create(attendance_params)
		msg = "Thanks, #{attendance.student.name}. You're checked in."

		redirect_to new_event_checkin_path(params[:event_id]), notice: msg
	end

	private

	def attendance_params
		params.require(:attendance).permit(:movie_id, :student_id, :event_id)
	end

end