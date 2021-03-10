# frozen_string_literal: true

require 'rails_helper'
require 'support/shared_examples_for_a_curated_model_accessed_by_an_unauthorized_user'
require 'support/shared_examples_for_a_curated_model_accessed_by_an_user_without_curator_rights'
require 'support/shared_examples_for_a_curated_model_accessed_by_a_curator'

RSpec.describe '/release_heads', type: :request do
  it_behaves_like 'a curated model accessed by an unauthorized user', 'release_head'
  it_behaves_like 'a curated model accessed by an user without curator rights', 'release_head'
  it_behaves_like 'a curated model accessed by a curator', 'release_head'

  describe 'GET /index' do
    it 'renders a successful response' do
      ReleaseHead.create! FactoryBot.attributes_for(:release_head)
      get release_heads_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      release_head = ReleaseHead.create! FactoryBot.attributes_for(:release_head)
      get release_head_url(release_head)
      expect(response).to be_successful
    end
  end
end
