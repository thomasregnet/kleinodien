# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'
require 'test_data'

# rubocop:disable Metrics/BlockLength
RSpec.describe PersistBrainzArtistCredit do
  it_behaves_like 'a service'

  context 'when the ArtistCredit already exists' do
    describe '.call' do
      let!(:artist_credit) do
        FactoryBot.create(:artist_credit, name: 'Jello Biafra With NoMeansNo')
      end

      let(:blueprint) do
        TestData.by_name(:brainz_release_the_sky_is_falling_gb_cd)
                .blueprint.artist_credit
      end

      it 'returns the ArtistCredit' do
        expect(described_class.call(blueprint: blueprint))
          .to eq(artist_credit)
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

      # rubocop:disable RSpec/MultipleExpectations
      # rubocop:disable RSpec/MessageSpies
      it 'returns the ArtistCredit' do
        proxy = spy
        expect(proxy).to receive(:get).and_return(jello_biafra)
        expect(proxy).to receive(:get).and_return(nomeansno)

        expect(described_class.call(blueprint: blueprint, proxy: proxy))
          .to be_instance_of(ArtistCredit)
      end
      # rubocop:enable RSpec/MessageSpies
      # rubocop:enable RSpec/MultipleExpectations
    end
  end
end
# rubocop:enable Metrics/BlockLength
