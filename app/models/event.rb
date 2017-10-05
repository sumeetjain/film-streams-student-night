class Event < ActiveRecord::Base
  include EventsHelper
  DEFAULT_TITLE = "Free Movie Night"

	has_many :movies
  has_many :attendances


	
	validates :date, presence: true
  validates :title, presence: true
  validates :location, presence: true
  # Get the title of the event, or the default.
  # 
  # Returns the title String.
  def title
    self.attributes["title"] || DEFAULT_TITLE
  end

  def self.past_events
    Event.where("date < ?", Date.today).reverse
  end

  def self.most_recent_past
    Event.past_events[0..9]
  end

  enum location: {
    'Ruth Sokolof'             => 0,
    'Dundee'                      => 1,
  }
end
