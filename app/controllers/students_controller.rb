# Every action in this controller has params[:event_id].

class StudentsController < ApplicationController
  before_filter :set_event, :set_colors

  # This is where user ends up if they're new to Film Streams!
  # We want to collect more info about them.
  # 
  # GET /events/1/students/new
  #             :event_id
  def new
    @checkin = "true"
    @student = Student.new(email: flash[:email])
  end

  # This is where user ends up if they've been to Film Streams before.
  # We're just asking them to verify our information about them.
  # 
  # GET /events/1/students/99
  #             :event_id  :id
  def edit
    @checkin = "true"
    @student = Student.find(params[:id])
    @referral = Referral.new(student: @student)    
  end

  # The new-student form submits here.
  # If their profile is valid, forward them on to complete their attendance.
	def create
		@student = Student.new(student_params)

  	if @student.save
      @student.add_to_mailchimp
      flash[:student_id] = @student.id
      @student.add_referrals(params[:referrals])
      redirect_to new_event_attendance_path(params[:event_id])
    else  
      render :new
    end

  end

  # The edit-student form submits here.
  # If their profile is valid, forward them on to complete their attendance.
  def update
    @student = Student.find(params[:id])

    @student.update_referrals(params[:referrals])

    if @student.update_attributes(student_params)
      flash[:student_id] = @student.id
      redirect_to new_event_attendance_path(params[:event_id])
    else
      render :edit
    end
  end

  private

	def student_params
		params.require(:student).permit(:email, :name, :school_id, :year, :zip, :newsletter)
	end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_colors
    @colors = true
  end


end