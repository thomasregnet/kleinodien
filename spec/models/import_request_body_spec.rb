# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImportRequestBody, type: :model do
  context 'with valid data' do
    let(:body) { FactoryBot.build(:import_request_body) }

    it 'is valid' do
      expect(body).to be_valid
    end
  end

  describe '#content' do
    context 'when blank' do
      let(:body) { FactoryBot.build(:import_request_body, content: '') }

      it 'is not valid' do
        expect(body).not_to be_valid
      end
    end

    context 'when nil' do
      let(:body) { FactoryBot.build(:import_request_body, content: nil) }

      it 'is not valid' do
        expect(body).not_to be_valid
      end
    end
  end

  describe '#import_order' do
    context 'when nil' do
      let(:body) do
        FactoryBot.build(
          :import_request_body, import_request: nil
        )
      end

      it 'is not valid' do
        expect(body).not_to be_valid
      end
    end
  end
end
