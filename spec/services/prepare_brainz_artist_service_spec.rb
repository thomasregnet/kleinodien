# frozen_string_literal: true

require 'rails_helper'
require 'redis_helper'
require 'shared_examples_for_services'

RSpec.describe PrepareBrainzArtistService do
  it_behaves_like 'a service'

  def reference
    @reference ||= BrainzArtistReference.from_code(
      '2280ca0e-6968-4349-8c36-cb0cbd6ee95f'
    )
  end

  def cache_key
    "cache:#{reference.to_uri}"
  end

  let(:args) do
    {
      reference: reference,
      importer_name: 'test'
    }
  end

  context 'when nothing is cached' do
    it 'returns nil' do
      expect(described_class.call(args)).to be false
    end
  end

  context 'when the artist is stored' do
    before do
      DatabaseCleaner.start
      RedisHelper.import_store.set(cache_key, '<fake xml>')
    end

    it 'returns true' do
      expect(described_class.call(args)).to be true
    end

    after { DatabaseCleaner.clean }
  end
end
