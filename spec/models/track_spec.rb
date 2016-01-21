require 'rails_helper'

RSpec.describe Track, type: :model do
  before(:each) do
    @track = FactoryGirl.create(:track)
  end

  it 'is valid with valid attributes' do
    expect(@track).to be_valid
  end

  it 'is not valid without a release' do
    @track.release = nil
    expect(@track).not_to be_valid
  end

  context 'belonging to a CompilationRelease' do
    before(:each) do
      @track = FactoryGirl.create(:track_with_compilation_release)
    end

    it 'knows its CompilationRelease' do
      expect(@track.compilation).to be_instance_of(CompilationRelease)
    end
  end

  context 'with a format' do
    before(:each) do
      @track = FactoryGirl.create(:track_with_format)
    end

    it 'belongs to its format' do
      expect(@track.format).to be_instance_of(TrFormatKind)
    end
  end

  context 'with details' do
    before(:each) do
      @track = FactoryGirl.create(:track_with_details)
    end

    it 'sees its details' do
      expect(@track.details.count).to eq(3)
    end
  end

  context 'with duration' do
    before(:each) do
      @track = FactoryGirl.create(:track)
      @track.duration = Duration.new(311000, 'second')
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
  end
end
