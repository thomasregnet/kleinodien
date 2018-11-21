# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImportRequestAttempt, type: :model do
  context 'with valid prameters' do
    let(:attempt) { FactoryBot.build(:import_request_attempt) }

    it 'is valid' do
      expect(attempt).to be_valid
    end

    it 'can be persisted' do
      expect(attempt.save).to be_truthy
    end
  end

  describe '#status_code' do
    context 'when less than 100' do
      let(:attempt) do
        FactoryBot.build(:import_request_attempt, status_code: 99)
      end

      it 'is not valid' do
        expect(attempt).not_to be_valid
      end
    end

    context 'when greater than 999' do
      let(:attempt) do
        FactoryBot.build(:import_request_attempt, status_code: 1000)
      end

      it 'is not valid' do
        expect(attempt).not_to be_valid
      end
    end

    context 'when nil' do
      let(:attempt) do
        FactoryBot.build(:import_request_attempt, status_code: nil)
      end

      it 'is not valid' do
        expect(attempt).not_to be_valid
      end
    end

    context 'when blank' do
      let(:attempt) do
        FactoryBot.build(:import_request_attempt, status_code: '')
      end

      it 'is not valid' do
        expect(attempt).not_to be_valid
      end
    end
  end

  describe '#import_request' do
    context 'when nil' do
      let(:attempt) do
        FactoryBot.build(:import_request_attempt, import_request: nil)
      end

      it 'is not valid' do
        expect(attempt).not_to be_valid
      end
    end
  end
end
