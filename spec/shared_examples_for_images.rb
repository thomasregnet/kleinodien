# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'an image' do
  it { should belong_to(:import_order).optional }
  
  it { should have_and_belong_to_many(:tags) }
  it { should respond_to(:coverartarchive_code) }
  it { should respond_to(:back_cover) }
  it { should respond_to(:file) }
  it { should respond_to(:front_cover) }
  it { should respond_to(:note) }

  describe 'either front or back' do
    context 'when front and back are not true' do
      before do
        subject.front_cover = false
        subject.back_cover = false
      end

      it 'is valid' do
        expect(subject).to be_valid
      end
    end

    context 'when front is true and back is not true' do
      before do
        subject.front_cover = true
        subject.back_cover = false
      end

      it 'is valid' do
        expect(subject).to be_valid
      end
    end

    context 'when front is not true and back is true' do
      before do
        subject.front_cover = false
        subject.back_cover = true
      end

      it 'is valid' do
        expect(subject).to be_valid
      end
    end

    context 'when front and back is true' do
      before do
        subject.front_cover = true
        subject.back_cover = true
      end

      it 'is not valid' do
        expect(subject).not_to be_valid
      end
    end
  end
end
