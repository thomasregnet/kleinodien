# frozen_string_literal: true

require 'rails_helper'
require 'support/shared_examples_for_non_user_attempt_to_access_a_curated_model'

RSpec.describe '/artists', type: :request do
  it_behaves_like 'non user attempt to access a curated model', 'artist'
end
