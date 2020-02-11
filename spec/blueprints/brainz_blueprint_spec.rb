# frozen_string_literal: true

require 'rails_helper'
require 'test_data'

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

  describe '#incomplete_begin/end_date' do
    context 'when it contains a begin_date and an end_date' do
      let(:xml) do
        <<~END_XML
          <?xml version="1.0" encoding="UTF-8"?>
          <metadata xmlns="http://musicbrainz.org/ns/mmd-2.0#">
            <fake begin-date="2000-10-11" end-date="2010-11-12">
           </fake>
          </metadata>
        END_XML
      end
      let(:blueprint) do
        described_class.from_xml(xml)
      end

      it '#incomplete_begin_date returns an IncompleteDate' do
        expect(blueprint.incomplete_begin_date)
          .to be_instance_of(IncompleteDate)
      end

      it '#incomplete_end_date returns an IncompleteDate' do
        expect(blueprint.incomplete_end_date)
          .to be_instance_of(IncompleteDate)
      end
    end

    context 'when it does not contain a begin_date and no end_date' do
      let(:xml) do
        <<~END_XML
          <?xml version="1.0" encoding="UTF-8"?>
          <metadata xmlns="http://musicbrainz.org/ns/mmd-2.0#">
            <fake><mock></mock></fake>
          </metadata>
        END_XML
      end
      let(:blueprint) do
        bp = described_class.from_xml(xml)
        bp
      end

      it '#incomplete_begin_date returns nil' do
        expect(blueprint.incomplete_begin_date).to be_nil
      end

      it '#incomplete_end_date returns nil' do
        expect(blueprint.incomplete_end_date).to be_nil
      end
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

  describe '#flat_track_list' do
    context 'without any tracks' do
      let(:blueprint) { described_class.new }

      it 'returns nil' do
        expect(blueprint.flat_track_list).to be_nil
      end
    end

    context 'with tracks' do
      let(:blueprint) do
        TestData.by_name(:brainz_release_arise_jp_cd)
                .blueprint.media[0]
      end

      it 'returns the flat track_list' do
        expect(blueprint.flat_track_list.length).to eq(3)
      end
    end

    context 'with tracks and data-tracks' do
      let(:blueprint) do
        TestData.by_name(:brainz_release_powerslave_enhanced_cd)
                .blueprint.media[0]
      end

      it 'returns the flat track_list' do
        expect(blueprint.flat_track_list.length).to eq(10)
      end
    end
  end

  describe '#milliseconds' do
    let(:blueprint) do
      TestData.by_name(:brainz_recording_highway_to_hell).blueprint
    end

    it 'returns the milliseconds' do
      expect(blueprint.milliseconds).to eq(208_000)
    end
  end
end
