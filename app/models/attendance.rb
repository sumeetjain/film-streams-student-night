class Attendance < ActiveRecord::Base

	belongs_to :movie
	belongs_to :student
	belongs_to :event

end
