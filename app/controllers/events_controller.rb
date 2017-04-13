class EventsController < ApplicationController

	def index
	end

	def new
		if load_current_user
			@event = Event.new
		else
			redirect_to :root
		end
	end

	def show
		if load_current_user
			@event = Event.find(params[:id])
		else
			redirect_to :root
		end
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
		@event.update_attributes(event_params)
		redirect_to(:back)
	end
	
	def event_params
		params.require(:event).permit(:title, :date)
	end
end
