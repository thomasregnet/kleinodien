# frozen_string_literal: true

require 'fake_proxy'
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

      let(:proxy) { FakeProxy.new }
      let(:args) do
        {
          blueprint:    blueprint,
          import_order: FactoryBot.create(:brainz_release_import_order),
          proxy:        proxy
          # proxy:        FakeProxy.new
        }
      end

      it 'fetches the needed area' do
        described_class.call(args)
        expect(proxy.matches(%r{/area/})).to eq(1)
      end
    end
  end
end
