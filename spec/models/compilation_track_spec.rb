require 'rails_helper'

RSpec.describe CompilationTrack, type: :model do
  context 'simple track' do
    before(:all) do
      DatabaseCleaner.start
      @track = FactoryGirl.build(:compilation_track)
    end

    it 'is valid with valid attributes' do
      expect(@track).to be_valid
    end

    it 'is not valid without a release' do
      @track.piece_release = nil
      expect(@track).not_to be_valid
    end

    after(:all) do
      DatabaseCleaner.clean
    end
  end

  context 'belonging to a CompilationRelease' do
    before(:each) do
      @track = FactoryGirl.build(:compilation_track_with_compilation_release)
    end

    it 'knows its CompilationRelease' do
      expect(@track.compilation_release).to be_instance_of(CompilationRelease)
    end
  end

  context 'with a format' do
    before(:each) do
      @track = FactoryGirl.build(:compilation_track_with_format)
    end

    it 'belongs to its format' do
      expect(@track.format).to be_instance_of(TrFormatKind)
    end
  end

  context 'with details' do
    before(:each) do
      @track = FactoryGirl.create(:compilation_track_with_details)
    end

    it 'sees its details' do
      expect(@track.details.count).to eq(3)
    end
  end

  context 'with repository_positions' do
    before(:each) do
      @track = FactoryGirl.create(:compilation_track_with_repository_positions)
    end

    it 'can use repository positions' do
      expect(@track.repository_positions.count).to eq(3)
    end

    specify 'the repository_positions have set their foreign key' do
      repo_pos = @track.repository_positions[0]
      expect(repo_pos.compilation_release_id).not_to be_nil
    end
  end

  context 'with duration' do
    before(:each) do
      DatabaseCleaner.start
      @track = FactoryGirl.build(:compilation_track)
      @track.duration = Duration.new(311_000, 'second')
    end

    it 'is valid' do
      expect(@track).to be_valid
    end

    it 'can be saved' do
      expect { @track.save! }.not_to raise_error
    end

    it 'returns the duration in mm:ss format' do
      expect(@track.duration.mmss).to eq('5:11')
    end

    after(:each) do
      DatabaseCleaner.clean
    end
  end

  context 'with a format' do
    before(:all) do
      DatabaseCleaner.start
      @track = FactoryGirl.build(
        :compilation_track,
        new_format: CtFormat.find('FLAC')
      )
    end

    it 'is valid' do
      expect(@track).to be_valid
    end

    after(:all) do
      DatabaseCleaner.clean
    end
  end
end
