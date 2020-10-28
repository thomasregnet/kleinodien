# frozen_string_literal: true

RSpec.shared_examples 'a ReleaseCopy' do
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
    before do
        subject.release_head = nil
        subject.release = FactoryBot.build(:release, title: 'release title')
    end

    it 'is valid' do
      expect(subject).to be_valid
    end

    describe '#title' do
      it 'returns the title of the release' do
        expect(subject.title).to eq('release title')
      end
    end
  end

  context 'with a ReleaseHead' do
    before do
      subject.release = nil
      subject.release_head = FactoryBot.build(:release_head, title: 'release_head title')
    end

    it 'is valid' do
      expect(subject).to be_valid
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
        .to contain_exactly([:base, ['there can be eigther a Release or a ReleaseHead']])
    end
  end

  context 'with neigther a Release nor ReleaseHead' do
    it 'is not valid' do
      subject.release      = nil
      subject.release_head = nil
      subject.valid?

      expect(subject.errors.messages)
        .to contain_exactly([:base, ['there must be eigther a Release or a ReleaseHead']])
    end
  end
end