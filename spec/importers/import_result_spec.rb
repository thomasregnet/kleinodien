# frozen_string_literal: true

require 'rails_helper'

# Fake a result for testing
class FakeImportedItem
  def fake
    true
  end
end

RSpec.describe ImportResult do
  subject { described_class.new(result: FakeImportedItem.new) }

  it { is_expected.to respond_to('created?') }
  it { is_expected.to respond_to(:result) }
  it { is_expected.to respond_to(:fake) }

  describe '#created?' do
    context 'when no parameter was given' do
      let(:import_result) do
        described_class.new(result: FakeImportedItem.new)
      end

      it 'returns false' do
        expect(import_result.created?).to be false
      end
    end

    context 'when the parameter "created" was true' do
      let(:import_result) do
        described_class.new(result: FakeImportedItem.new, created: true)
      end

      it 'returns true' do
        expect(import_result.created?).to be true
      end
    end
  end
end
