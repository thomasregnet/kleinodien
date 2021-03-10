# frozen_string_literal: true

require 'rails_helper'
require 'support/shared_examples_for_a_curated_model_accessed_by_an_unauthorized_user'
require 'support/shared_examples_for_a_curated_model_accessed_by_an_user_without_curator_rights'
require 'support/shared_examples_for_a_curated_model_accessed_by_a_curator'

RSpec.describe '/artists', type: :request do
  it_behaves_like 'a curated model accessed by an unauthorized user', 'artist'
  it_behaves_like 'a curated model accessed by an user without curator rights', 'artist'
  it_behaves_like 'a curated model accessed by a curator', 'artist'

  describe 'GET /index' do
    it 'renders a successful response' do
      FactoryBot.create(:artist)
      get artists_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      artist = FactoryBot.create(:artist)
      get artist_url(artist)
      expect(response).to be_successful
    end
  end
end
