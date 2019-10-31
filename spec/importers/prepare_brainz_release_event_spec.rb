# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'
require 'test_data'

RSpec.describe PrepareBrainzReleaseEvent do
  it_behaves_like 'a service'

  describe '#prepare' do
    context 'with valid parameters' do
      let(:blueprint) do
        TestData.by_name(:brainz_release_the_sky_is_falling_gb_cd)
                .blueprint.release_events.first
      end

      let(:args) do
        {
          blueprint:    blueprint,
          import_order: FactoryBot.create(:brainz_release_import_order),
          proxy:        spy
        }
      end

      it 'prepares' do
        area_preparer = class_double('PrepareBrainzArea').as_stubbed_const
        allow(area_preparer).to receive(:call)

        described_class.call(args)

        expect(area_preparer).to have_received(:call)
      end
    end
  end
end
