# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PrepareBase do
  describe '#call' do
    context 'when an exception is thrown within "prepare"' do
      let(:import_order) { spy }
      let(:pre_base) do
        described_class.new(
          import_order: import_order,
          proxy:        :fake_proxy
        )
      end

      it 'calls "failure" in the ImportOrder' do
        pre_base.define_singleton_method(:prepare) { raise 'wicked' }
        pre_base.call
        expect(import_order).to have_received('failure!')
      end
    end
  end
end
