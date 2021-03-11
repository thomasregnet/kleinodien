# frozen_string_literal: true

require 'shared_examples_for_incomplete_dates'

RSpec.shared_examples 'an area alias' do
  subject do
    described_class.new(
      area:      FactoryBot.create(:area),
      name:      'test alias',
      sort_name: 'alias test'
    )
  end

  it { should respond_to(:gone) }
  it { should respond_to(:locale) }

  context 'with valid parameters' do
    # let(:area) { described_class.new(name: 'test area') }
    let(:area_alias) do
      described_class.new(
        area:      FactoryBot.create(:area),
        name:      'test alias',
        sort_name: 'alias test'
      )
    end

    it 'is valid' do
      expect(area_alias).to be_valid
    end
  end

  describe '#name' do
    context 'when nil' do
      let(:area) { described_class.new }

      it 'is not valid' do
        expect(area).not_to be_valid
      end
    end

    context 'when blank' do
      let(:area) { described_class.new(name: '') }

      it 'is not valid' do
        expect(area).not_to be_valid
      end
    end
  end

  # describe '#begin_date' do
  #   it_behaves_like 'a model with an IncompleteDate' do
  #     let(:candidate) do
  #       described_class.new(
  #         area: FactoryBot.create(:area),
  #         name: 'test area'
  #       )
  #     end

  #     let(:date_naming) { 'begin_date' }
  #   end
  # end

  # describe '#end_date' do
  #   it_behaves_like 'a model with an IncompleteDate' do
  #     let(:candidate) do
  #       described_class.new(
  #         area: FactoryBot.create(:area),
  #         name: 'test area'
  #       )
  #     end

  #     let(:date_naming) { 'end_date' }
  #   end
  # end

  describe '#sort_name' do
    context 'when blank' do
      let(:area) { described_class.new(name: 'test area', sort_name: '') }

      it 'is not valid' do
        expect(area).not_to be_valid
      end
    end

    context 'when nil and the name has a value' do
      let(:area) { described_class.new(name: 'test area') }

      it 'sets the sort_name on validation if none is given' do
        area.valid?
        expect(area.sort_name).to eq('test area')
      end
    end
  end
end
