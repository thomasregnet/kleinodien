# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_rateable_models'
require 'shared_examples_for_tagable_models'

RSpec.describe ArtistCredit, type: :model do
  it { is_expected.to have_many(:release_heads) }
  it { is_expected.to have_many(:releases) }
  it { is_expected.to belong_to(:import_order).without_validating_presence }

  it_behaves_like 'a rateable model' do
    let(:rateable) { FactoryBot.build(:artist_credit) }
  end

  it_behaves_like 'a tagable model' do
    let(:tagable) { FactoryBot.build(:artist_credit) }
  end

  context 'without a Source' do
    context 'when not persisted' do
      it 'is not valid without a participant' do
        artist_credit = FactoryBot.build(:artist_credit)
        artist_credit.participants = []
        artist_credit.name = nil
        expect(artist_credit).not_to be_valid
      end
    end

    context 'when persisted' do
      it 'must have a unique name' do
        artist_credit = FactoryBot.create(:artist_credit)
        clone = described_class.new(name: artist_credit.name)
        expect(clone).not_to be_valid
      end
    end
  end
end
