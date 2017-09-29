class ReferralsController < ApplicationController

	def new
		@checkin = Checkin.new
	end
end