# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'
require 'test_data'

# rubocop:disable Metrics/BlockLength
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

    describe 'key' do
      it 'has the expected name' do
        expect(result[0]).to eq('tracks')
      end
    end

    describe 'value' do
      let(:value) { result[1] }

      it 'returns an array for the value' do
        expect(value).to be_instance_of(Array)
      end

      it 'has the expected length' do
        expect(value.length).to eq(3)
      end

      it 'contains hashes' do
        expect(value.reject { |item| item.class == Hash }.length)
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

    describe 'key' do
      let(:key) { result[0] }

      it 'has the expected name' do
        expect(result[0]).to eq('iso_3166_1_codes')
      end
    end

    describe 'value' do
      let(:value) { result[1] }

      it 'returns the expected value' do
        expect(value[0]).to eq('JP')
      end

      it 'has a length of 1' do
        expect(result[1].length).to eq(1)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
