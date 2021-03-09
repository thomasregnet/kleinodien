# frozen_string_literal: true

require 'rails_helper'
require 'support/shared_examples_for_a_curated_model_accessed_by_an_unauthorized_user'

RSpec.describe '/artists', type: :request do
  it_behaves_like 'a curated model accessed by an unauthorized user', 'artist'
end
