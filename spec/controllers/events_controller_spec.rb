require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe '#new' do
    context 'when not logged in' do
      it 'redirects home' do
        #Setup 
        get :new
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when logged in' do
      it 'renders its view' do
        allow(controller).to receive(:load_current_user) { User.new }

        get :new
        expect(response).to render_template(:new)
      end
    end
  end

  describe '#show' do
    context 'when not logged in' do
      it 'redirects home' do
        allow(Event).to receive(:find) { Event.new(date: Date.today) }

        get :show, {id: "doesn't matter"}
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when logged in' do
      it 'renders its view' do
        allow(controller).to receive(:load_current_user) { User.new }
        allow(Event).to receive(:find) { Event.new(date: Date.today) }

        get :show, {id: "doesn't matter"}
        expect(response).to render_template(:show)
      end
    end
  end

  describe '#create' do
    context 'when event saves' do
      it 'redirects to event' do
        # Setup
        # Exercise / Verify
        get :create, {:event => {title: "Free Movie Night", date: Date.today}}
        expect(response).to render_template(@event)
      end
    end
  end



end
