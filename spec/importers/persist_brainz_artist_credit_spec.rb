# frozen_string_literal: true

require 'fake_proxy'
require 'rails_helper'
require 'shared_examples_for_services'
require 'test_data'

RSpec.describe PersistBrainzArtistCredit do
  it_behaves_like 'a service'

  context 'when the ArtistCredit already exists' do
    describe '.call' do
      let!(:artist_credit) do
        FactoryBot.create(:artist_credit, name: 'Jello Biafra With NoMeansNo')
      end

      let(:args) do
        blueprint = TestData.by_name(:brainz_release_the_sky_is_falling_gb_cd)
                            .blueprint.artist_credit

        {
          blueprint:    blueprint,
          import_order: :fake_import_order,
          proxy:        :fake_proxy
        }
      end

      it 'returns the ArtistCredit' do
        expect(described_class.call(args)).to eq(artist_credit)
      end
    end
  end

  context 'when the ArtistCredit is not persisted' do
    describe '.call' do
      let(:blueprint) do
        TestData.by_name(:brainz_release_the_sky_is_falling_gb_cd)
                .blueprint.artist_credit
      end

      let(:jello_biafra) do
        TestData.by_name(:brainz_artist_jello_biafra).blueprint
      end

      let(:nomeansno) do
        TestData.by_name(:brainz_artist_nomeansno).blueprint
      end

      it 'returns the ArtistCredit' do
        args = {
          blueprint:    blueprint,
          import_order: FactoryBot.create(:brainz_import_order),
          proxy:        FakeProxy.new
        }

        expect(described_class.call(args))
          .to be_instance_of(ArtistCredit)
      end
    end
  end
end
