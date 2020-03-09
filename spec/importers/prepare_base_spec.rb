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

  describe 'respond_to_missing?' do
    let(:base) do
      described_class.new(
        import_order: :fake_import_order,
        proxy:        :fake_proxy
      )
    end

    context 'when able to respond' do
      before do
        stub_const('PrepareTestGizmo', 1)
        base.define_singleton_method(:prepare_infix) { :test }
      end

      it 'returns true' do
        expect(base.send(:respond_to_missing?, :prepare_gizmo)).to be_truthy
      end
    end

    context 'when unable to respond' do
      before { base.define_singleton_method(:prepare_infix) { :test } }

      it 'returns false' do
        expect(base.send(:respond_to_missing?, :prepare_gizmo)).to be_falsey
      end
    end
  end

  context 'when called with an prepare_* method that can not be called' do
    let(:preparer) do
      preparer = described_class.new(
        import_order: :fake_import_order,
        proxy:        :fake_proxy
      )
      preparer.define_singleton_method(:prepare_infix) { :some_stuff }

      preparer
    end

    it 'raises a NoMethodError' do
      expect { preparer.prepare_gizmo }
        .to raise_error(NoMethodError, /undefined method `prepare_gizmo'/)
    end
  end

  describe '#prepare_infix' do
    it 'raises a NoMethodError' do
      preparer = described_class.new(
        import_order: :fake_import_order,
        proxy:        :fake_proxy
      )
      expect { preparer.prepare_infix }
        .to raise_error(NoMethodError, /PrepareBase#prepare_infix\z/)
    end
  end
end
