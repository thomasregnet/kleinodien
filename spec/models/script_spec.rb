# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Script, type: :model do
  # it  { should have_many(:releases) }

  it { should validate_length_of(:iso_code).is_equal_to(4) }
  it { should validate_presence_of(:iso_code) }

  it { should validate_presence_of(:name) }

  context 'with valid parameters' do
    let(:script) { FactoryBot.build(:script) }

    it 'is valid' do
      expect(script).to be_valid
    end
  end

  describe '#code_number'
end
