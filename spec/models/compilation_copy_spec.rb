require 'rails_helper'
require 'brainz_test_helper'

RSpec.describe CompilationCopy, type: :model do
  context 'test in a lab' do
    before(:each) do
      @copy = FactoryGirl.create(:compilation_copy)
    end

    it 'is valid with valid attributes' do
      expect(@copy).to be_valid
    end

    it 'is not valid without a release' do
      @copy.release = nil
      expect(@copy).not_to be_valid
    end

    it 'raises without a release' do
      @copy.release = nil
      expect { @copy.save! validate: false }
        .to raise_error(/PG::NotNullViolation: ERROR/)
    end

    it 'is not valid without an user' do
      @copy.user = nil
      expect(@copy).not_to be_valid
    end

    it 'raises without a user' do
      @copy.user = nil
      expect { @copy.save! validate: false }
        .to raise_error(/PG::NotNullViolation: ERROR/)
    end
  end

  context 'dirty tests on real release' do
    before(:all) do
      DatabaseCleaner.start
      @brz_release = BrainzTestHelper
                     .get_release('c8f7094d-ce27-365e-961f-0af27321be08')
      @x_release = Brainz::InsertRelease.perform(@brz_release)
      @release = AlbumRelease.find(@x_release.id)
      @repository = FactoryGirl.create(:repository)
      @co_copy    = FactoryGirl.create(
        :compilation_copy,
        release: @release,
        user:    @repository.user
      )
    end

    # TODO: This is just a proove of concept, code and structure...
    # TODO: ...realy suck!
    it 'works' do
      @release.tracks.each do |track|
        RepositoryPosition.new(
          release:           @release,
          repository:        @repository,
          compilation_track: track,
          compilation_copy:  @co_copy
        )
      end
    end

    after(:all) do
      DatabaseCleaner.clean
    end
  end
end
