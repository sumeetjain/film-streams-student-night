require 'rails_helper'

RSpec.describe CheckinController, type: :controller do
  describe '#create' do
    it 'redirects to student/show' do
      # Setup
      post 'create', :student => {"email" => "email@example.com", "email_confirmation" => "email@example.com"}
      # Exercise
      expect(response).to redirect_to("/students/show")
      expect(flash[:danger]).to be_falsey
      expect(session[:info]).to be_truthy

    end

    it 'redirects to /checkin' do
      # Setup
      post 'create', :student => {"email" => "invalid", "email_confirmation" => "invalid"}
      # Exercise
      expect(response).to redirect_to("/checkin/")
      expect(flash[:danger]).to be_truthy
      expect(session[:info]).to be_falsey
      
    end
  end 
end