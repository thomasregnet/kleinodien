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

  # rubocop:disable RSpec/VerifiedDoubles
  describe '#title' do
    context 'when a title is given' do
      it 'returns that title' do
        blueprint = double(title: 'fake title')
        subset = described_class.new(blueprint: blueprint)
        expect(subset.title).to eq('fake title')
      end
    end

    context 'when no title is given' do
      it 'returns a generic title' do
        format = double(__content__: 'Vinyl')
        blueprint = double(format: format, position: 3, title: nil)
        subset = described_class.new(blueprint: blueprint)
        expect(subset.title).to eq('Vinyl 3')
      end
    end
  end
  # rubocop:enable RSpec/VerifiedDoubles
end
