# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_import_requests'

RSpec.describe ImportRequest, type: :model do
  # TODO: add some specs for the base-class
  # For now no specs here. The "type"-column is "NOT NULL" so
  # all specs fail because in rails the "type" of the base-class is nil.
  # https://stackoverflow.com/questions/4858122/rails-sti-and-the-setting-of-the-type-string
  # include_examples 'for ImportRequests', :import_request
  describe '#processing' do
    context 'when state is "pending"' do
      let(:import_request) { FactoryBot.build(:import_request) }

      it 'returns true' do
        expect(import_request.processing).to be_truthy
      end

      it 'sets the state to processing' do
        import_request.processing

        expect(import_request.state).to eq('processing')
      end
    end

    context 'when state is already "processing"' do
      let(:import_request) do
        FactoryBot.build(:import_request, state: :processing)
      end

      it 'returns false' do
        expect(import_request.processing).to be_falsey
      end
    end
  end

  describe '#done' do
    context 'when state is "pending"' do
      let(:import_request) { FactoryBot.build(:import_request) }

      it 'returns true' do
        expect(import_request.done).to be_truthy
      end

      it 'sets the state to done' do
        import_request.done

        expect(import_request.state).to eq('done')
      end
    end

    context 'when state is already "done"' do
      let(:import_request) do
        FactoryBot.build(:import_request, state: :done)
      end

      it 'returns false' do
        expect(import_request.done).to be_falsey
      end
    end
  end

  describe '#failed' do
    context 'when state is "pending"' do
      let(:import_request) { FactoryBot.build(:import_request) }

      it 'returns true' do
        expect(import_request.failed).to be_truthy
      end

      it 'sets the state to failed' do
        import_request.failed

        expect(import_request.state).to eq('failed')
      end
    end

    context 'when state is "done"' do
      let(:import_request) do
        FactoryBot.build(:import_request, state: :done)
      end

      it 'returns false' do
        expect(import_request.failed).to be_falsey
      end
    end

    context 'when state is already "failed"' do
      let(:import_request) do
        FactoryBot.build(:import_request, state: :failed)
      end

      it 'returns false' do
        expect(import_request.failed).to be_falsey
      end
    end
  end
end
