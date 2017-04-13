require 'rails_helper'

RSpec.describe CheckinController, type: :controller do
  describe '#create' do
    it 'redirects to student/show' do
      # Setup
      post 'create', :student => {"email" => "email@example.com", "email_confirmation" => "email@example.com"}
      # Exercise
      expect(response).to redirect_to("/students/show")

      post 'create', :student => {"email" => "email", "email_confirmation" => "email"}
      # Exercise
      expect(response).to redirect_to("/checkin/")
    end

  end 

end