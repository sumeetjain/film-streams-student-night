class Attendance < ActiveRecord::Base
	belongs_to :student
	belongs_to :event
	belongs_to :movie
end
