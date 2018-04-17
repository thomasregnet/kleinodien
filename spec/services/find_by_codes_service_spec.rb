# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

RSpec.describe FindByCodesService do
  it_behaves_like 'a service'

  def brainz_code
    'fdfea6f4-6c8e-4200-ba46-c797831cedae'
  end

  before { DatabaseCleaner.start }

  let(:args) do
    {
      model_class: Artist,
      attributes: {
        unused: nil,
        brainz_code: brainz_code,
        discogs_code: 123
      }
    }
  end

  context 'when nothing can be found by codes' do
    it 'returns nil' do
      expect(described_class.call(args)).to be_nil
    end
  end

  context 'when an entity can be found by codes' do
    before do
      FactoryBot.create(:artist, brainz_code: brainz_code)
    end

    it 'returns the model' do
      expect(described_class.call(args)).to be_instance_of(Artist)
    end
  end
  after { DatabaseCleaner.clean }
end
