# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

# rubocop:disable Metrics/BlockLength
RSpec.describe FindByCodesService do
  it_behaves_like 'a service'

  def brainz_code
    'fdfea6f4-6c8e-4200-ba46-c797831cedae'
  end

  def default_args
    {
      model_class: Artist,
      codes_hash: {
        unused:       nil,
        brainz_code:  brainz_code,
        discogs_code: 123
      }
    }
  end

  context 'when nothing can be found by codes' do
    before { DatabaseCleaner.start }

    after { DatabaseCleaner.clean }

    let(:args) { default_args }

    it 'returns nil' do
      expect(described_class.call(args)).to be_nil
    end
  end

  context 'when an entity can be found by codes' do
    before do
      DatabaseCleaner.start
      FactoryBot.create(:artist, brainz_code: brainz_code)
    end

    after { DatabaseCleaner.clean }

    let(:args) { default_args }

    it 'returns the model' do
      expect(described_class.call(args)).to be_instance_of(Artist)
    end
  end

  context 'when no codes can be compared' do
    let(:args) do
      {
        model_class: Artist,
        codes_hash: {
          foo_code: 123,
          bar_code: 'thirsty'
        }
      }
    end

    it 'returns nil' do
      expect(described_class.call(args)).to be_nil
    end
  end
end
# rubocop:enable Metrics/BlockLength
