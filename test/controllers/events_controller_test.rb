require 'test_helper'
require "minitest/mock"

class EventsControllerTest < ActionController::TestCase
  test '#new redirects home if not logged in' do
    get :new
    assert_redirected_to(root_path)
  end

  test '#new renders its view if logged in' do
    # Setup
    @controller.stub :load_current_user, User.new do

      # Exercise
      get :new

      # Verify
      assert_template :new

    end
  end

  test '#show redirects home if not logged in' do
    get(:show, {id: 1})
    assert_redirected_to(root_path)
  end

  test '#show renders its view if logged in' do
    # Setup
    @controller.stub :load_current_user, User.new do

      # Exercise
      get(:show, {id: 1})

      # Verify
      assert_template :show

    end
  end
end
