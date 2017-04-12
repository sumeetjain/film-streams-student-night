class EventsController < ApplicationController

	def index
	end

	def new
		@event = Event.new
	end

	def show
		@event = Event.find(params[:id])
	end

	def create
		@event = Event.new(event_params)
		@event.save
		redirect_to @event
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
