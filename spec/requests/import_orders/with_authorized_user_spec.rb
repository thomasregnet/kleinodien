# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/import_orders with authorized user', type: :request do
  let(:invalid_attributes) { { state: 'evil' } }
  let(:user) { FactoryBot.create(:user, importer: true) }
  let(:valid_attributes) do
    FactoryBot.attributes_for(:import_order).merge(
      import_queue: FactoryBot.create(:import_queue)
    )
  end
  let(:import_order) { FactoryBot.create(:import_order, user: user) }

  before { sign_in user }

  describe 'GET /index' do
    it 'renders a successful response' do
      get import_orders_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    let(:import_order) { FactoryBot.create(:brainz_release_import_order, user: user)}

    it 'renders a successful response' do
      get import_order_url(import_order)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_import_order_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      get edit_import_order_url(import_order)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new ImportOrder' do
        expect do
          attr = FactoryBot.attributes_for(:import_order).merge(
            import_queue_id: FactoryBot.create(:import_queue).id,
            user_id:         user.id
          )
          post import_orders_url, params: { import_order: attr }
        end.to change(ImportOrder, :count).by(1)
      end

      it 'redirects to the created import_order' do
        attr = FactoryBot.attributes_for(:import_order).merge(
          import_queue_id: FactoryBot.create(:import_queue).id,
          user_id:         user.id
        )
        post import_orders_url, params: { import_order: attr }
        expect(response).to redirect_to(import_order_url(ImportOrder.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new ImportOrder' do
        expect do
          post import_orders_url, params: { import_order: invalid_attributes }
        end.to change(ImportOrder, :count).by(0)
      end

      it 'renders a successful response' do
        post import_orders_url, params: { import_order: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        # skip('Add a hash of attributes valid for your model')
        { code: 'yet another code', user: user }
      end

      it 'updates the requested import_order' do
        # import_order = ImportOrder.create! valid_attributes
        patch import_order_url(import_order), params: { import_order: new_attributes }
        import_order.reload
        # We assume 302 to be OK. Is it?
        expect(response.status).to eq(302)
      end

      it 'redirects to the import_order' do
        patch import_order_url(import_order), params: { import_order: new_attributes }
        import_order.reload
        expect(response).to redirect_to(import_order_url(import_order))
      end
    end

    context 'with invalid parameters' do
      it 'redirects to the new_import_order_url' do
        patch import_order_url(import_order), params: { import_order: invalid_attributes }
        expect(response).to redirect_to(edit_import_order_url(import_order))
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested import_order' do
      import_order = FactoryBot.create(:import_order, user: user)
      expect do
        delete import_order_url(import_order)
      end.to change(ImportOrder, :count).by(-1)
    end

    it 'redirects to the import_orders list' do
      import_order = FactoryBot.create(:import_order)
      delete import_order_url(import_order)
      expect(response).to redirect_to(import_orders_url)
    end
  end
end
