class Sessions

	def initialize(params)
		@event_id = params[:id]
		@email = params[:student][:email]
	end

end