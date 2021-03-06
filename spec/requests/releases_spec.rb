# frozen_string_literal: true

require 'rails_helper'
require 'support/shared_examples_for_a_curated_model_accessed_by_an_unauthorized_user'
require 'support/shared_examples_for_a_curated_model_accessed_by_an_user_without_curator_rights'
require 'support/shared_examples_for_a_curated_model_accessed_by_a_curator'

RSpec.describe '/releases', type: :request do
  it_behaves_like 'a curated model accessed by an unauthorized user', 'release'
  it_behaves_like 'a curated model accessed by an user without curator rights', 'release'
  it_behaves_like 'a curated model accessed by a curator', 'release'

  describe 'GET /index' do
    it 'renders a successful response' do
      FactoryBot.create(:release)
      get releases_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      release = FactoryBot.create(:release)
      get release_url(release)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    let(:release_head) { FactoryBot.create(:release_head) }
    let(:valid_params) do
      { release: FactoryBot.attributes_for(:release).merge(release_head_id: release_head.id) }
    end

    before { login_as(FactoryBot.create(:user, curator: true)) }

    context 'with valid parameters' do
      it 'creates a new release' do
        expect { post releases_url, params: valid_params }.to change(Release, :count).by(1)
      end

      it 'redirects to the created release' do
        post releases_url valid_params
        expect(response).to redirect_to(release_url(Release.last))
      end
    end
  end
end
