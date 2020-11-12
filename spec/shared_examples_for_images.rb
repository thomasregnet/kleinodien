# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'an image' do
  it { should respond_to(:archive_org_code) }
  it { should respond_to(:back) }
  it { should respond_to(:file) }
  it { should respond_to(:front) }
  it { should respond_to(:note) }

  describe 'eigther front or back' do
    context 'when front and back are not true' do
      before do
        subject.front = false
        subject.back = false
      end

      it 'is valid' do
        expect(subject).to be_valid
      end
    end

    context 'when front is true and back is not true' do
      before do
        subject.front = true
        subject.back = false
      end

      it 'is valid' do
        expect(subject).to be_valid
      end
    end

    context 'when front is not true and back is true' do
      before do
        subject.front = false
        subject.back = true
      end

      it 'is valid' do
        expect(subject).to be_valid
      end
    end

    context 'when front and back is true' do
      before do
        subject.front = true
        subject.back = true
      end

      it 'is not valid' do
        expect(subject).not_to be_valid
      end
    end
  end
end
