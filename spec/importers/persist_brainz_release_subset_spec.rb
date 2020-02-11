# frozen_string_literal: true

require 'rails_helper'
require 'test_data'

RSpec.describe PersistBrainzReleaseSubset do
  let(:blueprint) { TestData.by_name(:brainz_release_arise_jp_cd).blueprint }

  # TODO: test medium with a given title
  # Suggestion: "The Making of the Wretched Spawn"
  context 'with valid parameters' do
    let(:import_order) do
      FactoryBot.create(:brainz_import_order)
    end

    it 'persists the subset' do
      args = {
        blueprint:    blueprint.media[0],
        import_order: :fake,
        release:      FactoryBot.create(:release),
        proxy:        BrainzProxy.new(import_order: import_order)
      }
      allow(PersistBrainzReleaseTrack).to receive(:call)
      expect(described_class.call(args).new_record?).to be false
    end
  end

  # rubocop:disable RSpec/VerifiedDoubles
  describe '#title' do
    context 'when a title is given' do
      let(:args) do
        blueprint = double(title: 'fake title')

        {
          blueprint:    blueprint,
          import_order: :fake,
          proxy:        :fake_proxy,
          release:      FactoryBot.create(:release)
        }
      end

      it 'returns that title' do
        subset = described_class.new(args)
        expect(subset.title).to eq('fake title')
      end
    end

    context 'when no title is given' do
      let(:args) do
        format = double(__content__: 'Vinyl')
        blueprint = double(format: format, position: 3, title: nil)
        {
          blueprint:    blueprint,
          import_order: :fake,
          proxy:        :fake_proxy,
          release:      FactoryBot.create(:release)
        }
      end

      it 'returns a generic title' do
        # blueprint = double(format: format, position: 3, title: nil)
        subset = described_class.new(args)
        expect(subset.title).to eq('Vinyl 3')
      end
    end
  end
  # rubocop:enable RSpec/VerifiedDoubles
end
