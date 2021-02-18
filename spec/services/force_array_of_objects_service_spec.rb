# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

class TestClass
  def initialize(args)
    @args = args
  end
end

RSpec.describe ForceArrayOfObjectsService do
  it_behaves_like 'a service'

  context 'when there is no value' do
    it 'returns nil' do
      expect(described_class.call(klass: TestClass, value: nil)).to be_nil
    end
  end

  context 'when there is a single value' do
    it 'returns an Array' do
      expect(described_class.call(klass: TestClass, value: 'some string')).to be_kind_of(Array)
    end
  end

  context 'when there is an Array as value' do
    let(:test_array) { [TestClass.new('test'), TestClass.new('array')] }

    it 'returns an Array' do
      expect(described_class.call(klass: TestClass, value: test_array)).to be_instance_of(Array)
    end
  end
end
