require 'rails_helper'
require 'shared_examples_for_commentable'
require 'shared_examples_for_rateable_models'
require 'shared_examples_for_tagable_models'

RSpec.describe ArtistCredit, type: :model do
  specify '#descriptions' do
    expect(subject).to respond_to(:descriptions)
  end

  it { is_expected.to(belong_to(:data_import)) }

  it_behaves_like 'a commentable model' do
    before(:all) do
      DatabaseCleaner.start
      @artist_credit = FactoryGirl.create(:artist_credit)
    end

    let(:commentable) { @artist_credit }

    after(:all) { DatabaseCleaner.clean }
  end

  it_behaves_like 'a rateable model' do
    before(:all) do
      DatabaseCleaner.start
      @artist_credit = FactoryGirl.create(:artist_credit)
    end

    let(:rateable) { @artist_credit }

    after(:all) { DatabaseCleaner.clean }
  end

  it_behaves_like 'a tagable model' do
    before(:all) do
      DatabaseCleaner.start
      @tagable = FactoryGirl.create(:artist_credit)
    end

    let(:tagable) { @tagable }

    after(:all) { DatabaseCleaner.clean }
  end

  context 'without a Source' do
    context 'not saved to the database' do
      before(:each) do
        @artist_credit = FactoryGirl.build(:artist_credit)
      end

      it { is_expected.to respond_to(:artists) }

      it 'is valid with valid attributes' do
        expect(@artist_credit).to be_valid
      end

      it 'is not valid without a participant' do
        @artist_credit.participants = []
        @artist_credit.name = nil
        expect(@artist_credit).not_to be_valid
      end
    end

    context 'saved to the database' do
      before(:all) do
        DatabaseCleaner.start
        @artist_credit = FactoryGirl.create(:artist_credit)
      end

      # TODO: let this test pass again
      # it 'raises an error when it sets its participants to null' do
      #   expect { @artist_credit.participants = [] }
      #     .to raise_error(/null value in column "artist_credit_id"/)
      # end

      it 'must have a unique name' do
        clone = ArtistCredit.new(name: @artist_credit.name)
        expect(clone).not_to be_valid
      end

      after(:all) do
        DatabaseCleaner.clean
      end
    end
  end

  context 'CompilationRelease' do
    specify '#compilation_releases' do
      artist_credit = FactoryGirl.create(:artist_credit)
      compilation_release = artist_credit.compilation_releases.create!(
        title: 'Awesome album',
        type: 'AlbumRelease',
        head: FactoryGirl.create(:compilation_head)
      )
      expect(compilation_release).to be_instance_of(AlbumRelease)
    end
  end

  context 'SongRelease' do
    before(:all) do
      DatabaseCleaner.start
      @artist_credit = FactoryGirl.create(:artist_credit)
    end

    it 'foobar' do
      song_release = @artist_credit.song_releases.create!(
        head: FactoryGirl.create(:song_head)
      )

      expect { song_release.save! }.not_to raise_error
    end

    after(:all) do
      DatabaseCleaner.clean
    end
  end
  context 'with Source' do
    before(:all) do
      DatabaseCleaner.start
      @artist_credit = FactoryGirl.create(:artist_credit_with_source)
    end

    it 'is valid' do
      expect(@artist_credit).to be_valid
    end

    it 'must have an unique name' do
      clone = ArtistCredit.new(
        name:   @artist_credit.name,
        source: @artist_credit.source
      )
      expect(clone).not_to be_valid
    end

    it 'must not have an unique name when the Source differs' do
      clone = ArtistCredit.new(
        participants:  @artist_credit.participants,
        source:        FactoryGirl.create(:source)
      )
      expect { clone.save! }.not_to raise_error
    end

    after(:all) do
      DatabaseCleaner.clean
    end
  end
end
