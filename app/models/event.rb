class Event < ActiveRecord::Base
	has_many :movies
	
	validates :date, presence: true
end
