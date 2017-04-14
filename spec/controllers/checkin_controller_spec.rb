require 'rails_helper'

RSpec.describe CheckinsController, type: :controller do
  describe '#show' do
    it 'clears session[:info]' do
      get :show, {}, {info: 1}

      expect(session[:info]).to be_nil
    end

    it 'renders its view' do
      get :show

      expect(response).to render_template(:show)
    end
  end

  describe '#create' do
    context "with valid info" do
      it "save their info to the session" do
        
      end

      it "redirects to /students/show" do
        # Setup
        post 'create', :student => {"email" => "email@example.com", "email_confirmation" => "email@example.com"}
        # Exercise
        expect(response).to redirect_to("/students/show")
        expect(flash[:danger]).to be_falsey
        expect(session[:info]).to be_truthy
      end
    end


    context "with invalid info" do
      it "add flash message" do
        
      end
      
      it "redirect to checkin page" do
        # Setup
        post 'create', :student => {"email" => "invalid", "email_confirmation" => "invalid"}
        # Exercise
        expect(response).to redirect_to("/checkin/")
        expect(flash[:danger]).to be_truthy
        expect(session[:info]).to be_falsey        
      end
    end

  end 
end