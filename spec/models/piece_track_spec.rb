# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PieceTrack, type: :model do
  before do
    @track = FactoryBot.build(:piece_track)
  end

  it 'is valid with valid attributes' do
    expect(FactoryBot.build(:piece_track)).to be_valid
  end

  it 'is not valid without a Piece' do
    # track.piece = nil
    track = FactoryBot.build(:piece_track, piece: nil)
    expect(track).not_to be_valid
  end

  # TODO: shared_exampes_for_duration
  # this spec was cut and pasted from compilation_tracks
  context 'with duration' do
    let(:track) do
      track = FactoryBot.build(:piece_track)
      track.duration = Duration.new(311_000, 'second')
      track
    end

    it 'is valid' do
      expect(track).to be_valid
    end

    it 'can be saved' do
      expect { track.save! }.not_to raise_error
    end

    it 'returns the duration in mm:ss format' do
      expect(track.duration.mmss).to eq('5:11')
    end
  end
end
