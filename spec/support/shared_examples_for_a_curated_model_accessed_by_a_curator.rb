# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'a curated model accessed by a curator' do |kind|
  let(:instance) { FactoryBot.create(kind.to_sym) }
  let(:invalid_params) { { kind => { evil: 'dead' } } }
  let(:model_class) { kind.camelize.constantize }
  let(:user) { FactoryBot.create(:user, curator: true) }
  let(:valid_params) { { kind => FactoryBot.attributes_for(kind.to_sym) } }

  before { login_as(user) }

  describe 'GET /new' do
    it 'renders a successful response' do
      url = send "new_#{kind}_url"
      get url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      url = send "edit_#{kind}_url", instance
      get url
      expect(response).to be_successful
    end
  end

  # rubocop:disable RSpec/MultipleMemoizedHelpers
  describe 'POST /create' do
    let(:url) { send "#{kind.pluralize}_url" }

    context 'with valid parameters' do
      it "creates a new #{kind.camelize}" do
        expect { post url, params: valid_params }.to change(model_class, :count).by(1)
      end

      it "redirects to the created #{kind.camelize}" do
        post url, params: valid_params
        target_url = send "#{kind}_url", model_class.last
        expect(response).to redirect_to(target_url)
      end
    end

    context 'with invalid parameters' do
      it "does not create a new #{kind.camelize}" do
        expect { post url, params: invalid_params }.to change(model_class, :count).by(0)
      end

      it 'renders a successful response' do
        post url, params: invalid_params
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH /update' do
    let(:url) { send "#{kind}_url", instance }

    context 'with valid parameters' do
      before do
        patch url, params: { kind => FactoryBot.attributes_for(kind.to_sym) }
        instance.reload
      end

      it "updates the #{kind.camelize}" do
        expect(response.status).to eq(302)
      end

      it "redirects to the #{kind.camelize}" do
        expect(response).to redirect_to(url)
      end
    end

    context 'with invalid parameters' do
      it "redirects to the edit_#{kind}_url" do
        patch url, params: invalid_params
        kind_url = send "#{kind}_url", instance
        expect(response).to redirect_to(kind_url)
      end
    end
  end

  describe 'DELETE /destroy' do
    let!(:url) { send "#{kind}_url", instance }

    it "destroys the requested #{kind}" do
      expect { delete url }.to change(model_class, :count).by(-1)
    end

    it "redirects to the #{kind.pluralize} list" do
      delete url
      index_url = send "#{kind.pluralize}_url"
      expect(response).to redirect_to(index_url)
    end
  end
  # rubocop:enable RSpec/MultipleMemoizedHelpers
end
