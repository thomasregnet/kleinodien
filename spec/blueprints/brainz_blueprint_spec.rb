# frozen_string_literal: true

require 'rails_helper'
require 'test_data'

# rubocop:disable Metrics/BlockLength
RSpec.describe BrainzBlueprint do
  it '#relation_lists'
  it '#url_relations'
  it '#codes_hash'
  it 'brainz_code'

  describe '.from_xml' do
    let(:xml) do
      TestData.by_name(:brainz_release_arise_jp_cd).raw
    end

    it 'returns the blueprint' do
      expect(described_class.from_xml(xml)).to be_instance_of described_class
    end
  end

  describe '#join_name' do
    let(:artist_credit) do
      TestData.by_name(:brainz_release_the_sky_is_falling_gb_cd)
              .blueprint.artist_credit
    end

    it 'returns the join_name' do
      expect(artist_credit.join_name).to eq('Jello Biafra With NoMeansNo')
    end
  end

  describe '#discogs_code' do
    context 'when the blueprint contains a discogs url' do
      let(:blueprint) do
        TestData.by_name(:brainz_artist_sepultura).blueprint
      end

      it 'returns the discogs-code' do
        expect(blueprint.discogs_code).to eq('34058')
      end
    end

    context 'when the blueprint does not contain a discogs url' do
      let(:blueprint) do
        TestData.by_name(:brainz_release_arise_jp_cd).blueprint
      end

      it 'returns the discogs-code' do
        expect(blueprint.discogs_code).to be_nil
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
