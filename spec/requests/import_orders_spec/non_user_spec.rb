# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/import_orders without an user', type: :request do
  let(:import_order) { FactoryBot.create(:import_order, user: user) }
  let(:user) { FactoryBot.create(:user) } # User has no "importer" rights
  let(:valid_attributes) do
    FactoryBot.attributes_for(:import_order).merge(
      import_queue: FactoryBot.create(:import_queue)
    )
  end

  describe 'GET /index' do
    it 'redirects to the sign_in page' do
      get import_orders_url
      expect(response).to redirect_to(new_user_session_url)
    end
  end

  describe 'GET /show' do
    it 'redirects to the sign_in page' do
      get import_order_url(import_order)
      expect(response).to redirect_to(new_user_session_url)
    end
  end

  describe 'GET /new' do
    it 'redirects to the sign_in page' do
      get new_import_order_url
      expect(response).to redirect_to(new_user_session_url)
    end
  end

  describe 'GET /edit' do
    it 'redirects to the sign_in page' do
      get edit_import_order_url(import_order)
      expect(response).to redirect_to(new_user_session_url)
    end
  end

  describe 'POST /create' do
    it 'redirects to the sign_in page' do
      attr = FactoryBot.attributes_for(:import_order).merge(
        import_queue_id: FactoryBot.create(:import_queue).id,
        user_id:         user.id
      )
      post import_orders_url, params: { import_order: attr }
      expect(response).to redirect_to(new_user_session_url)
    end
  end

  describe 'PATCH /update' do
    let(:new_attributes) do
      { code: 'yet another code', user: user }
    end

    it 'redirects to the sign_in page' do
      patch import_order_url(import_order), params: { import_order: new_attributes }
      import_order.reload
      expect(response).to redirect_to(new_user_session_url)
    end
  end

  describe 'DELETE /destroy' do
    it 'does not destroy the requested import_order' do
      import_order = FactoryBot.create(:import_order, user: user)
      expect do
        delete import_order_url(import_order)
      end.not_to change(ImportOrder, :count)
    end

    it 'redirects to the sign_in page' do
      import_order = FactoryBot.create(:import_order)
      delete import_order_url(import_order)
      expect(response).to redirect_to(new_user_session_url)
    end
  end
end
