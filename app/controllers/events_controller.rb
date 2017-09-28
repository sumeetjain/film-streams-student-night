class EventsController < ApplicationController

	def index
		@events = Event.where("date > ?", 1.days.ago)
		if !@events.nil?
			@events.sort_by {|obj| obj.date}
		end
		@events = @events.sort_by {|obj| obj.date}
	end

	def new
		if load_current_user
			@event = Event.new
		else
			redirect_to root_path
		end
	end

	def show
		if load_current_user
			@event = Event.find(params[:id])
		else
			redirect_to root_path
		end
	end

	def destroy
		if load_current_user
			event = Event.find(params[:id])
			event.delete
			flash[:alert] = "Event deleted."
		end 
	    redirect_to events_path
	end

	def create
		@event = Event.new(event_params)
		if @event.save
			redirect_to @event
		else 
			render 'new'
		end
	end

	def update
		@event = Event.find(params[:id])
		if @event.update_attributes(event_params)
			flash[:notice] = "Event updated!"
		else
			flash[:alert] = "Invalid Event Info"
		end
		redirect_to event_path(@event.id)
	end

	def hidden
	end
	
	def event_params
		params.require(:event).permit(:title, :date)
	end
end