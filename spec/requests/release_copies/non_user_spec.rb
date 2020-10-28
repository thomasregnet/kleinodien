# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/release_copies', type: :request do
  describe 'GET /index' do
    it 'rediricts to the sign_in page' do
      get release_copies_url
      expect(response).to redirect_to(new_user_session_url)
    end
  end

  describe 'GET /show' do
    it 'rediricts to the sign_in page' do
      get release_copy_url(1)
      expect(response).to redirect_to(new_user_session_url)
    end
  end

  describe 'GET /new' do
    it 'rediricts to the sign_in page' do
      get new_release_copy_url
      expect(response).to redirect_to(new_user_session_url)
    end
  end

  describe 'GET /edit' do
    it 'rediricts to the sign_in page' do
      get edit_release_copy_url(1)
      expect(response).to redirect_to(new_user_session_url)
    end
  end

  describe 'POST /create' do
    it 'redirects to the sign_in page' do
      post release_copies_url, params: {}
      expect(response).to redirect_to(new_user_session_url)
    end
  end

  describe 'PATCH /update' do
    it 'redirects to the sign_in page' do
      patch release_copy_url(1), params: {}
      expect(response).to redirect_to(new_user_session_url)
    end
  end

  describe 'DELETE /destroy' do
    it 'does not destroy the requested ReleaseCopy' do
      release_copy = FactoryBot.create(:release_copy)
      expect { delete release_copy_url(release_copy) }.not_to change(ReleaseCopy, :count)
    end

    it 'redirects to the sign_in page' do
      release_copy = FactoryBot.create(:release_copy)
      delete release_copy_url(release_copy)
      expect(response).to redirect_to(new_user_session_url)
    end
  end
end
