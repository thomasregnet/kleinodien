require 'rails_helper'

RSpec.describe TestSet do
  let(:test_set) { described_class.new }

  describe '#define' do
    it 'yields' do
      expect { |block| test_set.define(&block) }. to yield_with_args(TestSubset)
    end
  end
end
