# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PrepareBase do
  describe '#call' do
    context 'when an exception is thrown within "prepare"' do
      let(:import_order) { spy }
      let(:preparer) do
        preparer = described_class.new(
          import_order: import_order,
          proxy:        :fake_proxy
        )
        preparer.define_singleton_method(:prepare) { raise 'wicked' }

        preparer
      end

      it 'raises that exception' do
        expect { preparer.call }.to raise_error(RuntimeError, 'wicked')
      end


      # rubocop:disable Lint/SuppressedException
      # rubocop:disable Lint/UselessAssignment
      it 'calls "failure" in the ImportOrder' do
        begin
          preparer.call
        rescue StandardError => e
        end

        expect(import_order).to have_received('failure!')
      end
      # rubocop:enable Lint/SuppressedException
      # rubocop:enable Lint/UselessAssignment
    end
  end
end
