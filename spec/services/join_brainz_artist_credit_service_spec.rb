# frozen_string_literal: true

require 'rails_helper'
require 'test_data'
require 'shared_examples_for_services'

RSpec.describe JoinBrainzArtistCreditService do
  it_behaves_like 'a service'

  context 'with more than one artist' do
    let(:blueprint) do
      TestData.by_name(:brainz_release_the_sky_is_falling_gb_cd)
              .blueprint.artist_credit.name_credits
    end

    it 'returns the joined artist names' do
      expect(described_class.call(name_credits: blueprint))
        .to eq('Jello Biafra With NoMeansNo')
    end
  end

  context 'with one artist' do
    let(:blueprint) do
      TestData.by_name(:brainz_release_arise_jp_cd)
              .blueprint.artist_credit.name_credits
    end

    it 'returns the artist' do
      expect(described_class.call(name_credits: blueprint))
        .to eq('Sepultura')
    end
  end
end
