# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'
require 'test_data'

RSpec.describe PrepareBrainzListService do
  it_behaves_like 'a service'

  # This method smells of :reek:UtilityFunction
  def arise
    xml = TestData.by_name(:brainz_release_arise_jp_cd).raw
    MultiXml.parse(xml)['metadata']['release']
  end

  context 'with a track-list' do
    let(:result) do
      track_list = arise['medium_list']['medium']['track_list']

      described_class.call(key: 'track_list', value: track_list)
    end

    it 'has a "tracks" key' do
      expect(result).to have_key('tracks')
    end

    it 'has set the track_offset' do
      expect(result['track_offset']).to eq('0')
    end

    it 'has set the track_count' do
      expect(result['track_count']).to eq('3')
    end

    describe 'listed items' do
      let(:list) { result['tracks'] }

      it 'returns an array for the value' do
        expect(list).to be_instance_of(Array)
      end

      it 'has the expected length' do
        expect(list.length).to eq(3)
      end

      it 'contains hashes' do
        expect(list.reject { |item| item.class == Hash }.length)
          .to be(0)
      end
    end
  end

  context 'with a iso_3166_1_list' do
    let(:result) do
      release_event = arise['release_event_list']['release_event']
      code_list = release_event['area']['iso_3166_1_code_list']

      described_class.call(key: 'iso_3166_1_code_list', value: code_list)
    end

    it 'has only one key' do
      expect(result.length).to eq(1)
    end

    it 'has an "iso_3166_1_codes" key' do
      expect(result).to have_key('iso_3166_1_codes')
    end

    describe 'listed items' do
      let(:list) { result['iso_3166_1_codes'] }

      it 'returns the expected value for the first list-item' do
        expect(list.first).to eq('JP')
      end

      it 'has a length of 1' do
        expect(list.length).to eq(1)
      end
    end
  end
end
