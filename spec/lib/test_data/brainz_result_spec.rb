# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_test_data_results'
require 'test_data/brainz_result'

RSpec.describe TestData::BrainzResult do
  xml_string = '<?xml version="1.0" encoding="UTF-8"?>' \
    '<metadata xmlns="http://musicbrainz.org/ns/mmd-2.0#">' \
    '<some_fake_data with="a fake attribute"></some_fake_data>' \
    '</metadata>'

  it_behaves_like 'a test-data result', xml_string, BrainzBlueprint
end
