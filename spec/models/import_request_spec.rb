# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_import_requests'

class FakeImportRequestToUri < ImportRequest
  def initialize(args)
    @args = args

    super(args)
  end

  attr_reader :args

  def to_uri
    "https://fake/#{args[:code]}"
  end
end

RSpec.describe ImportRequest, type: :model do
  # include_examples 'for ImportRequests', :import_request

  # TODO: add some specs for the base-class
  # For now no specs here. The "type"-column is "NOT NULL" so
  # all specs fail because in rails the "type" of the base-class is nil.
  # https://stackoverflow.com/questions/4858122/rails-sti-and-the-setting-of-the-type-string
  # include_examples 'for ImportRequests', :import_request

  # it_behaves_like(
  #   'an import state transitions capable object',
  #   :import_request
  # )

  it { is_expected.to have_many(:attempts) }
  it { is_expected.to have_one(:body) }

  it 'has a counter_cache for import_request_attempts' do
    import_request = FactoryBot.create(:brainz_artist_import_request)
    import_request.attempts.create!(status_code: 200)
    expect(import_request.attempts_count).to eq(1)
  end

  describe '.to_uri' do
    context 'when called on the base class' do
      let(:args) { FactoryBot.attributes_for(:import_order) }

      it 'throws an error' do
        expect { described_class.to_uri(args) }.to raise_error(
          NoMethodError, /to_uri/
        )
      end
    end

    context 'when called on an inheriting class that implements #to_uri' do
      it 'returns the uri' do
        expect(FakeImportRequestToUri.to_uri(code: 'abc123'))
          .to eq('https://fake/abc123')
      end
    end
  end
end
