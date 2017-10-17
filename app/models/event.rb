class Event < ActiveRecord::Base
  LOCATIONS = {
    ruth_sokolof: {
      title: "Ruth Sokolof",
      logo: "ruth_sokolof_logo.jpg",
      brand_colors: "#666666",
      welcome: "Welcome to the Ruth Sokolof Theater!"
    },
    dundee: {
      title: "The Dundee",
      logo: "dundee_logo_placeholder.png",
      brand_colors: "#759AAB",
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
    Event.where("date < ?", Date.today).reverse
  end

  def self.most_recent_past
    Event.past_events[0..9]
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
