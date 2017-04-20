class Movie < ActiveRecord::Base
	belongs_to :event
	has_many :attendances
	validates :time, presence: true
end
