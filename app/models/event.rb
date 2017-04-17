class Event < ActiveRecord::Base
  DEFAULT_TITLE = "Free Movie Night"

	has_many :movies
  has_many :attendances

	
	validates :date, presence: true
  validates :title, presence: true

  # Get the title of the event, or the default.
  # 
  # Returns the title String.
  def title
    self.attributes["title"] || DEFAULT_TITLE
  end
end
