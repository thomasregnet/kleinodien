# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HeapsController, type: :controller do

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    let(:heap) { FactoryBot.create(:heap) }

    it 'returns http success' do
      get :show, params: { id: heap.id }
      expect(response).to have_http_status(:success)
    end
  end
end
