# frozen_string_literal: true

require 'rails_helper'
require 'test_data/get_empty_image_service'

RSpec.describe Image, type: :model do
  it { should respond_to(:coverartarchive_code) }

  describe '#file' do
    let(:image) { described_class.new }

    context 'when attached' do
      before { image.file.attach(io: TestData::GetEmptyImageService.as_io, filename: 'an_image') }

      it 'returns an instance of ActiveStorage::Attached::One' do
        expect(image.file).to be_instance_of(ActiveStorage::Attached::One)
      end

      it 'is attached' do
        expect(image.file).to be_attached
      end
    end

    context 'when not attached' do
      it 'returns an instance of ActiveStorage::Attached::One' do
        expect(image.file).to be_instance_of(ActiveStorage::Attached::One)
      end

      it 'is attached' do
        expect(image.file).not_to be_attached
      end
    end
  end
end
