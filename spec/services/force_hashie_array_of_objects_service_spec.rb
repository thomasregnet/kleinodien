require 'rails_helper'
require 'shared_examples_for_services'

class TestClass
  def initialize(args)
    @args = args
  end
end

RSpec.describe ForceHashieArrayOfObjectsService do
  it_behaves_like 'a service'

  context 'when there is no value' do
    let(:args) { { value: nil, klass: TestClass } }

    it 'returns nil' do
      expect(described_class.call(args)).to be_nil
    end
  end

  context 'when there is a single value' do
    let(:args) { { value: 'some string', klass: TestClass } }

    it 'returns an Array' do
      expect(described_class.call(args)).to be_kind_of(Array)
    end
  end

  context 'when there is an Array as value' do
    let(:args) do
      test_array = [TestClass.new('test'), TestClass.new('array')]
      { klass: TestClass, value: test_array }
    end

    it 'returns an Array' do
      expect(described_class.call(args)).to be_instance_of(Array)
    end
  end

end
