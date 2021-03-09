# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'a curated model accessed by an unauthorized user' do |kind|
  let(:instance) { FactoryBot.create(kind) }
  let(:model_class) { kind.camelize.constantize }

  context 'when not logged in' do
    describe 'GET /new' do
      it 'redirects to the new_user_session_url' do
        url = send "new_#{kind}_url"
        get url
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe 'GET /edit' do
      it 'redirects to the new_user_session_url' do
        url = send "edit_#{kind}_url", instance
        get url
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe 'POST /create' do
      it 'redirects to the new_user_session_url' do
        url = send "#{kind.pluralize}_url"
        post url, params: {}
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe 'PATCH /update' do
      it 'redirects to the new_user_session_url' do
        url = send "#{kind}_url", instance
        patch url, params: {}
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe 'DELETE /destroy' do
      let(:url) { send "#{kind}_url", instance }

      before { instance.save! }

      it "does not destroy the #{kind}" do
        expect { delete url }.not_to change(model_class, :count)
      end

      it 'redirects to the new_user_session_url' do
        delete url
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end
end
