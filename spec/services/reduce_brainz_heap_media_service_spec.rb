# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'
require 'test_data'

# rubocop:disable Metrics/BlockLength
RSpec.describe ReduceBrainzHeapMediaService do
  it_behaves_like 'a service'

  # TODO: do this with a double album
  describe '.call' do
    context 'with a single "Enhanced CD"' do
      let(:media_formats) do
        blueprint = TestData.by_name(:brainz_release_powerslave_enhanced_cd)
                            .blueprint.media

        args = {
          blueprint:    blueprint,
          import_order: FactoryBot.create(:brainz_import_order)
        }
        described_class.call(args)
      end

      it 'returns a list' do
        # expect(described_class.call(args).length).to eq(1)
        expect(media_formats.length).to eq(1)
      end

      it 'has set the right quantity' do
        expect(media_formats.first[:quantity]).to eq(1)
      end

      it 'returns the right name for the first MediumFormat' do
        expect(media_formats.first[:medium_format].name).to eq('Enhanced CD')
      end
    end

    context 'when there are two media with the same type' do
      let(:media_formats) do
        blueprint = [
          Hashie::Mash.new(
            format: {
              brainz_code: '8a08dc62-1aa2-34de-a904-fa467c53052c',
              id:          '8a08dc62-1aa2-34de-a904-fa467c53052c',
              __content__: 'Enhanced CD'
            }
          ),
          Hashie::Mash.new(
            format: {
              brainz_code: '8a08dc62-1aa2-34de-a904-fa467c53052c',
              id:          '8a08dc62-1aa2-34de-a904-fa467c53052c',
              __content__: 'Enhanced CD'
            }
          )
        ]

        described_class.call(
          blueprint:    blueprint,
          import_order: FactoryBot.create(:brainz_import_order)
        )
      end

      it 'returns a list with one entry' do
        expect(media_formats.length).to eq(1)
      end

      it 'has set the right quantity' do
        expect(media_formats.first[:quantity]).to eq(2)
      end

      it 'returns the right name for the first MediumFormat' do
        expect(media_formats.first[:medium_format].name).to eq('Enhanced CD')
      end
    end

    context 'when a MediumFormat is unknown' do
      let(:media_formats) do
        blueprint = [
          Hashie::Mash.new(
            format: {
              brainz_code: '17841dee-4000-11e9-aee3-4b509b69e5e8',
              id:          '17841dee-4000-11e9-aee3-4b509b69e5e8',
              __content__: 'Total Unknown Medium Format'
            }
          )
        ]

        described_class.call(
          blueprint:    blueprint,
          import_order: FactoryBot.create(:brainz_import_order)
        )
      end

      it 'returns a list with one entry' do
        expect(media_formats.length).to eq(1)
      end

      it 'has set the right quantity' do
        expect(media_formats.first[:quantity]).to eq(1)
      end

      it 'returns the right name for the first MediumFormat' do
        expect(media_formats.first[:medium_format].name)
          .to eq('Total Unknown Medium Format')
      end

      it 'has set the ImportOrder of the MediumFormat' do
        expect(media_formats.first[:medium_format].import_order)
          .to be_instance_of(BrainzImportOrder)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
