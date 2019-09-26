# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PersistPrepareBase do
  describe '.call' do
    it 'responds to .call' do
      expect(described_class).to respond_to(:call)
    end
  end

  describe '#proxy' do
    let(:pp_base) { described_class.new(proxy: :fake_proxy) }

    it 'returns the proxy' do
      expect(pp_base.proxy).to eq(:fake_proxy)
    end
  end

  describe '#call' do
    context 'when not defined otherwise' do
      let(:base) { described_class.new(proxy: :dummy_proxy) }

      it 'raises an error' do
        expect { base.call }
          .to raise_error(NoMethodError, /undefined method/)
      end
    end
  end
end
