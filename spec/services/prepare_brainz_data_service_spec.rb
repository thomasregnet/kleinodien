# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'
require 'test_data'

# rubocop:disable Metrics/BlockLength
RSpec.describe PrepareBrainzDataService do
  it_behaves_like 'a service'

  describe 'length' do
    let(:prepared) do
      described_class.call(brainz_data: { 'length' => '123' })
    end

    it 'translated "length" to "milliseconds"' do
      expect(prepared[:milliseconds]).to eq(123)
    end

    it 'does not have a "lenght" key' do
      expect(prepared).not_to have_key('length')
    end
  end

  describe '_list' do
    let(:arise) do
      xml = TestData.by_name(:brainz_release_arise_jp_cd).raw
      MultiXml.parse(xml)['metadata']['release']
    end

    let(:prepared) { described_class.call(brainz_data: arise) }

    context 'with track_list' do
      let(:with_tracks) { prepared['media'].first }

      it 'has a "tracks" array' do
        expect(with_tracks['tracks']).to be_instance_of(Array)
      end

      it 'has the right "track_count"' do
        expect(with_tracks['track_count']).to eq('3')
      end

      it 'has the right "track_offset"' do
        expect(with_tracks['track_offset']).to eq('0')
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
