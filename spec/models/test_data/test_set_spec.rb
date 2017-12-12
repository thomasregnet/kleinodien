require 'rails_helper'

RSpec.describe TestData::TestSet do
  let(:test_set) { described_class.new }

  describe '#define' do
    it 'yields' do
      expect { |block| test_set.define(&block) }
        .to yield_with_args(TestData::Subset)
    end
  end

  describe 'retrieve' do
    context 'with a subset defined' do
      it 'returns that subset' do
        test_set.define {}
        expect(test_set.retrieve(0)).to be_instance_of(TestData::Subset)
      end
    end

    context 'with a wrong subset_no' do
      it 'raises an ArgumentError' do
        expect { test_set.retrieve(0) }.to raise_error(ArgumentError)
      end
    end
  end
end
