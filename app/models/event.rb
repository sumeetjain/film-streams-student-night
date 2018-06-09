class Event < ActiveRecord::Base
  LOCATIONS = {
    ruth_sokolof: {
      title: "Ruth Sokolof Theater",
      logo: "ruth_sokolof_logo.jpg",
      brand_colors: "#fff",
      welcome: "Welcome to the Ruth Sokolof Theater!"
    },
    dundee: {
      title: "Dundee Theater",
      logo: "dundee_logo.jpg",
      brand_colors: "#fff",
      welcome: "Welcome to the Dundee Theater!"
    }
  }

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
    Event.order(date: :desc)
  end

  def self.most_recent_past
    Event.order(date: :desc).limit(10)
  end

  def self.drop_locations
    theaters = []
    Event::LOCATIONS.each do |location, details|
      theaters << [details[:title], location]
    end
    return theaters
  end


  enum location: {
    :ruth_sokolof => 0,
    :dundee       => 1,
  }
end
