# frozen_string_literal: true

RSpec.shared_examples 'a ReleaseCopy' do
  it { should validate_presence_of(:designation) }
  it { should validate_uniqueness_of(:designation).scoped_to(:user_id) }

  context 'with valid parameters' do
    it 'is valid' do
      expect(subject).to be_valid
    end
  end

  context 'without an User' do
    it 'is not valid' do
      subject.user = nil

      expect(subject).not_to be_valid
    end
  end

  context 'with a Release' do
    let(:artist_credit) { FactoryBot.build(:artist_credit) }
    let(:release) { FactoryBot.build(:release, title: 'release title') }

    before do
      subject.release_head = nil
      subject.release = release
    end

    it 'is valid' do
      expect(subject).to be_valid
    end

    describe '#artist_credit' do
      it 'returns the ArtistCredit of the Release' do
        release.artist_credit = artist_credit
        expect(subject.artist_credit).to eq(artist_credit)
      end
    end

    describe '#title' do
      it 'returns the title of the release' do
        expect(subject.title).to eq('release title')
      end
    end
  end

  context 'with a ReleaseHead' do
    let(:artist_credit) { FactoryBot.build(:artist_credit) }
    let(:release_head) { FactoryBot.build(:release_head, title: 'release_head title') }

    before do
      subject.release = nil
      subject.release_head = release_head
    end

    it 'is valid' do
      expect(subject).to be_valid
    end

    describe '#artist_credit' do
      it 'returns the ArtistCredit of the ReleaseHead' do
        release_head.artist_credit = artist_credit
        expect(subject.artist_credit).to eq(artist_credit)
      end
    end

    describe '#title' do
      it 'returns the title of the ReleaseHead' do
        expect(subject.title).to eq('release_head title')
      end
    end
  end

  context 'with a Release and ReleaseHead' do
    it 'is not valid' do
      subject.release      = FactoryBot.build(:release)
      subject.release_head = FactoryBot.build(:release_head)
      subject.valid?

      expect(subject.errors.messages)
        .to contain_exactly([:base, ['there can be either a Release or a ReleaseHead']])
    end
  end

  context 'with neither a Release nor ReleaseHead' do
    it 'is not valid' do
      subject.release      = nil
      subject.release_head = nil
      subject.valid?

      expect(subject.errors.messages)
        .to contain_exactly([:base, ['there must be either a Release or a ReleaseHead']])
    end
  end
end
