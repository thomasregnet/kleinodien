# frozen_string_literal: true

RSpec.shared_examples 'a singleton' do
  describe '.new' do
    it 'throws a NoMethodError' do
      expect { described_class.new }.to raise_error(NoMethodError)
    end
  end

  describe '.instance' do
    it "returns an instance of it's class" do
      expect(described_class.instance).to be_instance_of(described_class)
    end

    it 'always returns the same instance' do
      expect(described_class.instance.object_id)
        .to eq(described_class.instance.object_id)
    end
  end
end
