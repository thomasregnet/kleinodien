# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UriImportOrdersController, type: :controller do
  describe 'GET #new' do
    context 'with an user logged in' do
      before do
        user = FactoryBot.create(:user)
        sign_in user
      end

      it 'returns http success' do
        get :new
        expect(response).to have_http_status(:success)
      end
    end

    context 'with no user logged in' do
      it 'redirects to /users/sign_in' do
        get :new
        expect(response).to redirect_to('/users/sign_in')
      end
    end
  end
end
