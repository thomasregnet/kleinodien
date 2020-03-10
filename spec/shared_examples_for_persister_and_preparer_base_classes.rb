# frozen_string_literal: true

require 'fake_proxy'
require 'mock_import_order'
require 'rails_helper'

RSpec.shared_examples 'a persister/preparer base-class' do
  subject do
    described_class.new(
      import_order: MockImportOrder.new,
      proxy:        FakeProxy.new
    )
  end

  it { is_expected.to(respond_to(:persist_prepare_infix)) }

  describe '#respond_to_missing?' do
    let(:base) do
      described_class.new(
        import_order: MockImportOrder.new,
        proxy:        FakeProxy.new
      )
    end

    context 'when able to respond' do
      before do
        if described_class.to_s.match?(/\APersist/)
          stub_const('PersistTestGizmo', 1)
        else
          stub_const('PrepareTestGizmo', 1)
        end

        base.define_singleton_method(:persist_prepare_infix) { :test }
      end

      let(:message) do
        if described_class.to_s.match?(/\APersist/)
          :persist_gizmo
        else
          :prepare_gizmo
        end
      end

      it 'returns true' do
        expect(base.send(:respond_to_missing?, message)).to be_truthy
      end
    end

    context 'when not able to respond' do
      it 'returns false' do
        expect(base.send(:respond_to_missing?, :persist_gizmo)).to be_falsey
      end
    end
  end
end
