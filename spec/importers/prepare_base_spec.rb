# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PrepareBase do
  describe '#call' do
    context 'when an exception is thrown within #prepare and the ImportOrder#state is "failed"' do
      let(:import_order) { spy }
      let(:preparer) { described_class.new(import_order: import_order, proxy: :fake_proxy) }

      before do
        allow(preparer).to receive(:prepare).and_raise('Bad Evil')
        allow(import_order).to receive(:failed?).and_return true
      end

      it 'raises the error' do
        expect { preparer.call }.to raise_error('Bad Evil')
      end

      # rubocop:disable Lint/SuppressedException
      # rubocop:disable Style/RescueStandardError
      it 'does not call #failure! on the import_order' do
        begin
          preparer.call
        rescue; end
        expect(import_order).not_to have_received(:failure!)
      end
      # rubocop:enable Style/RescueStandardError
      # rubocop:enable Lint/SuppressedException
    end

    context 'when an exception is thrown within #prepare and the ImportOrder#state is not "failed"' do
      let(:import_order) { spy }
      let(:preparer) { described_class.new(import_order: import_order, proxy: :fake_proxy) }

      before do
        allow(preparer).to receive(:prepare).and_raise('Bad Evil')
        allow(import_order).to receive(:failed?).and_return false
      end

      it 'raises the error' do
        expect { preparer.call }.to raise_error('Bad Evil')
      end

      # rubocop:disable Lint/SuppressedException
      # rubocop:disable Style/RescueStandardError
      it 'does not call #failure! on the import_order' do
        begin
          preparer.call
        rescue; end
        expect(import_order).to have_received(:failure!)
      end
      # rubocop:enable Style/RescueStandardError
      # rubocop:enable Lint/SuppressedException
    end
  end
end
