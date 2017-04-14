require 'rails_helper'

RSpec.describe CheckinsController, type: :controller do
  describe '#new' do
    it 'renders its view' do
      event = Event.create(title: "Student Night", date: Date.today)

      get :new, {event_id: event.id}

      expect(response).to render_template(:new)

      event.destroy
    end
  end

  describe '#create' do
    context "with valid info" do
      context "for existing user" do
        it "redirects to verify info page" do
          # Setup
          event = Event.create(title: "Student Night", date: Date.today)

          checkin_params = {
            email: "email@example.com",
            email_confirmation: "email@example.com"
          }

          allow_any_instance_of(Checkin).to receive(:student)    { true }
          allow_any_instance_of(Checkin).to receive(:student_id) { 1 }

          # Exercise
          post :create, {event_id: event.id, checkin: checkin_params}

          # Verify
          expect(response).to redirect_to edit_event_student_path(event.id, 1)

          # Teardown
          event.destroy
        end
      end

      context "for a new user" do
        it "redirects to add info page" do
          # Setup
          event = Event.create(title: "Student Night", date: Date.today)

          checkin_params = {
            email: "email@example.com",
            email_confirmation: "email@example.com"
          }

          allow_any_instance_of(Checkin).to receive(:student)    { nil }

          # Exercise
          post :create, {event_id: event.id, checkin: checkin_params}

          # Verify
          expect(response).to redirect_to new_event_student_path(event.id)

          # Teardown
          event.destroy
        end

        it "stores the email in the flash" do
          # Setup
          event = Event.create(title: "Student Night", date: Date.today)

          checkin_params = {
            email: "email@example.com",
            email_confirmation: "email@example.com"
          }

          allow_any_instance_of(Checkin).to receive(:student)    { nil }

          # Exercise
          post :create, {event_id: event.id, checkin: checkin_params}

          # Verify
          expect(flash[:email]).to eq("email@example.com")

          # Teardown
          event.destroy
        end
      end
    end

    context "with invalid info" do
      it "add flash message" do
        # Setup
        event = Event.create(title: "Student Night", date: Date.today)

        checkin_params = {
          email: "email@example.com",
          email_confirmation: "not-matching@example.com"
        }

        # Exercise
        post :create, {event_id: event.id, checkin: checkin_params}

        # Verify
        expect(flash[:alert]).to_not be_nil

        # Teardown
        event.destroy
      end
      
      it "redirect to checkin page" do
        # Setup
        event = Event.create(title: "Student Night", date: Date.today)

        checkin_params = {
          email: "email@example.com",
          email_confirmation: "not-matching@example.com"
        }

        # Exercise
        post :create, {event_id: event.id, checkin: checkin_params}

        # Verify
        expect(response).to redirect_to(new_event_checkin_path(event.id))

        # Teardown
        event.destroy
      end
    end

  end 
end