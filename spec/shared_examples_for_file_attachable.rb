# frozen_string_literal: true

require 'test_data/get_empty_image_service'

RSpec.shared_examples 'a file attachable' do
  describe '#file' do
    context 'when attached' do
      before { subject.file.attach(io: TestData::GetEmptyImageService.as_io, filename: 'an_image') }

      it 'returns an instance of ActiveStorage::Attached::One' do
        expect(subject.file).to be_instance_of(ActiveStorage::Attached::One)
      end

      it 'is attached' do
        expect(subject.file).to be_attached
      end
    end

    context 'when not attached' do
      it 'returns an instance of ActiveStorage::Attached::One' do
        expect(subject.file).to be_instance_of(ActiveStorage::Attached::One)
      end

      it 'is attached' do
        expect(subject.file).not_to be_attached
      end
    end
  end
end
