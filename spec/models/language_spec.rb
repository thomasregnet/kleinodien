# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe Language, type: :model do
  it { should validate_length_of(:iso_code_1).is_equal_to(2) }
  it { should validate_length_of(:iso_code_2b).is_equal_to(3) }
  it { should validate_length_of(:iso_code_2t).is_equal_to(3) }
  it { should validate_length_of(:iso_code_3).is_equal_to(3) }

  it { should validate_presence_of(:name) }

  context 'with valid parameters' do
    let(:lang) { FactoryBot.build(:language) }

    it 'is valid' do
      expect(lang).to be_valid
    end
  end

  describe '#iso_code_1' do
    context 'when valid' do
      let(:lang) { FactoryBot.build(:language, iso_code_1: 'az') }

      it 'is valid' do
        expect(lang).to be_valid
      end
    end

    context 'when format is wrong' do
      let(:lang) { FactoryBot.build(:language, iso_code_1: 'AZ') }

      it 'is not valid' do
        lang.valid?
        expect(lang.errors[:iso_code_1])
          .to include('must consist of two lowercase letters')
      end
    end
  end

  describe '#iso_code_2b' do
    context 'when valid' do
      let(:lang) { FactoryBot.build(:language, iso_code_2b: 'abc') }

      it 'is valid' do
        expect(lang).to be_valid
      end
    end

    context 'when format is wrong' do
      let(:lang) { FactoryBot.build(:language, iso_code_2b: 'ABC') }

      it 'is not valid' do
        lang.valid?
        expect(lang.errors[:iso_code_2b])
          .to include('must consist of three lowercase letters')
      end
    end
  end

  describe '#iso_code_2t' do
    context 'when valid' do
      let(:lang) { FactoryBot.build(:language, iso_code_2t: 'abc') }

      it 'is valid' do
        expect(lang).to be_valid
      end
    end

    context 'when format is wrong' do
      let(:lang) { FactoryBot.build(:language, iso_code_2t: 'ABC') }

      it 'is not valid' do
        lang.valid?
        expect(lang.errors[:iso_code_2t])
          .to include('must consist of three lowercase letters')
      end
    end
  end

  describe '#iso_code_3' do
    context 'when valid' do
      let(:lang) { FactoryBot.build(:language, iso_code_3: 'abc') }

      it 'is valid' do
        expect(lang).to be_valid
      end
    end

    context 'when format is wrong' do
      let(:lang) { FactoryBot.build(:language, iso_code_3: 'ABC') }

      it 'is not valid' do
        lang.valid?
        expect(lang.errors[:iso_code_3])
          .to include('must consist of three lowercase letters')
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
