# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

RSpec.describe PersistParticipantsService do
  it_behaves_like 'a service'

  describe '.call' do
    before do
      artists = []
      artists << FactoryBot.create(:artist, name: 'Slayer')
      artists << FactoryBot.create(:artist, name: 'Ice-T')

      described_class.call(
        artists:       artists,
        artist_credit: ArtistCredit.create!(name: 'Slayer & Ice-T'),
        join_phrases:  [' & ']
      )
    end

    context 'with the first artist' do
      let(:participant) do
        Artist.find_by(name: 'Slayer').participants.first
      end

      it 'has the right join_phrase' do
        expect(participant.join_phrase).to eq(' & ')
      end

      it 'has the right position' do
        expect(participant.position).to eq(0)
      end
    end

    context 'with the second artist' do
      let(:participant) do
        Artist.find_by(name: 'Ice-T').participants.first
      end

      it 'has the right join_phrase' do
        expect(participant.join_phrase).to be_nil
      end

      it 'has the right position' do
        expect(participant.position).to eq(1)
      end
    end
  end
end
