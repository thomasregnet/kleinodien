# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe Script, type: :model do
  # it  { should have_many(:releases) }

  it { should validate_length_of(:iso_code).is_equal_to(4) }
  it { should validate_presence_of(:iso_code) }

  it { should validate_length_of(:iso_number).is_equal_to(3) }

  it { should validate_presence_of(:name) }

  context 'with valid parameters' do
    let(:script) { FactoryBot.build(:script) }

    it 'is valid' do
      expect(script).to be_valid
    end
  end

  describe 'iso_code' do
    context 'when missformated' do
      let(:script) { FactoryBot.build(:script, iso_code: 'wXYZ') }

      it 'is not valid' do
        expect(script).not_to be_valid
      end

      it 'sets the expected error' do
        script.valid?
        expect(script.errors[:iso_code])
          .to include(
            'must consist of an uppercase letter' \
            + ' followed by three lowercase letters'
          )
      end
    end
  end

  describe '#iso_number' do
    context 'with the right format' do
      let(:script) { FactoryBot.build(:script, iso_number: '123') }

      it 'is valid' do
        expect(script).to be_valid
      end
    end

    context 'with a bad format' do
      let(:script) { FactoryBot.build(:script, iso_number: 'abc') }

      it 'is not valid' do
        expect(script).not_to be_valid
      end
      it 'sets the expected error' do
        script.valid?
        expect(script.errors[:iso_number])
          .to include('must consist of three digits')
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
