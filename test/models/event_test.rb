require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test '#title has a default' do
    event = Event.new

    assert(event.title == Event::DEFAULT_TITLE)
  end

  test '#title can be set in the constructor' do
    event = Event.new(title: "Banana")

    assert(event.title == "Banana")
  end

  test '#title can be set after the constructor' do
    event = Event.new

    event.title = "Banana"

    assert(event.title == "Banana")
  end

  test '#title cannot be made nil' do
    event = Event.new(title: "Banana")

    event.title = nil

    assert(event.title == Event::DEFAULT_TITLE)
  end
end
