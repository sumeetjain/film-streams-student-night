# Every action in this controller has params[:event_id].

class CheckinsController < ApplicationController

  before_filter :set_event

	def new
	end

	def create


    checkin = Checkin.new(params[:checkin])
    if checkin.valid?
      if checkin.student.id
        # Just verify the rest of your details. School? Grade?
        redirect_to edit_event_student_path(@event.id, checkin.student.id)
      else
        # We need more info! Fill out your student profile.
        flash[:email] = checkin.email
        redirect_to new_event_student_path(@event.id)
      end
    else
      flash[:alert] = "Emails must match and be valid."
      redirect_to new_event_checkin_path(@event.id)


    end
	end

  private

    def set_event
      @event = Event.find(params[:event_id])
    end

end