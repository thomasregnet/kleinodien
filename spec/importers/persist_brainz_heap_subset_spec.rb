# frozen_string_literal: true

require 'rails_helper'
require 'test_data'

RSpec.describe PersistBrainzHeapSubset do
  let(:blueprint) { TestData.by_name(:brainz_release_arise_jp_cd).blueprint }

  # TODO: test medium with a given title
  # Suggestion: "The Making of the Wretched Spawn"
  it 'persists the subset' do
    args = {
      blueprint: blueprint.media[0],
      heap:      FactoryBot.create(:heap),
      proxy:     nil
    }
    expect(described_class.call(args).new_record?).to be false
  end
end
