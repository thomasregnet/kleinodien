# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PersistPrepareBase do
  subject { described_class.new(proxy: spy) }

  it { is_expected.to respond_to(:call) }
  it { is_expected.to respond_to(:proxy) }

  describe '#call' do
    context 'when not defined otherwise' do
      let(:base) { described_class.new(proxy: :dummy_proxy) }

      it 'raises an error' do
        expect { base.call }
          .to raise_error(NotImplementedError, %r/missed to implement .call/)
      end
    end
  end
end
