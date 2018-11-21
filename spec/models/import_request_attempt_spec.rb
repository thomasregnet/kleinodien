# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImportRequestAttempt, type: :model do
  context 'with valid prameters' do
    let(:import_attempt) { FactoryBot.build(:import_request_attempt) }

    it 'is valid' do
      expect(import_attempt).to be_valid
    end
  end
end
