# frozen_string_literal: true

require 'ko_test_data'
require 'rails_helper'
require 'shared_examples_for_services'

RSpec.describe PersistBrainzArtistCredit do
  it_behaves_like 'a service'
end
