require 'rails_helper'

RSpec.shared_examples 'repository_positions' do
  it 'is valid' do
    expect(@position).to be_valid
  end

  it 'is not valid without an user' do
    @position.user = nil
    expect(@position).not_to be_valid
  end

  it 'is not valid without a reository' do
    @position.repository = nil
    expect(@position).not_to be_valid
  end
end

RSpec.describe RepositoryPosition, type: :model do
  context 'with a CompilationTrack' do
    before(:each) do
      @position = FactoryGirl.build(
        :repository_position_with_compilation_track
      )
    end

    include_examples 'repository_positions', @position

    it 'is not valid without a compilation_copy' do
      @position.compilation_copy = nil
      expect(@position).not_to be_valid
    end
  end

  context 'with a PieceTrack' do
    before(:each) do
      @position = FactoryGirl.build(:repository_position_with_piece_track)
    end

    include_examples 'repository_positions', @position
  end

  context 'with CompilationTrack and PieceTrack' do
    before(:each) do
      @position = FactoryGirl.build(
        :repository_position_with_compilation_track
      )
      @position.piece_track = FactoryGirl.build(:piece_track)
    end

    it 'is not valid' do
      expect(@position).not_to be_valid
      #byebug
    end
  end
end
