# Every action in this controller has params[:event_id].

class AttendancesController < ApplicationController

	def new
		# Use this to show the movies for this event.
		@event = Event.find(params[:event_id])

		# We need to pass this along.
		@student_id = flash[:student_id]
	end

	# Save this student's attendance, and redirect to the event's
	# main page for the next student to check in.
	def create
		Attendance.create(attendance_params)
		redirect_to new_event_checkin_path(params[:event_id])
	end

	private

	def attendance_params
		params.permit(:movie_id, :student_id, :event_id)
	end

end