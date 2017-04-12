class Event < ActiveRecord::Base
  DEFAULT_TITLE = "Strawberry"

	has_many :movies
	
	validates :date, presence: true

  # Get the title of the event, or the default.
  # 
  # Returns the title String.
  def title
    self.attributes["title"] || DEFAULT_TITLE
  end
end
