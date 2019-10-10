# frozen_string_literal: true

require 'rails_helper'
require 'test_data'
require 'shared_examples_for_services'

# Mock prepare_* calls
class MockPrepareBrainzReleaseGroup < PrepareBrainzReleaseGroup
  def initialize(prepare_artist_credit_spy:, **args)
    @prepare_artist_credit_spy = prepare_artist_credit_spy
    super(args)
  end

  attr_reader :prepare_artist_credit_spy

  def prepare_artist_credit
    prepare_artist_credit_spy.call
  end
end

RSpec.describe PrepareBrainzReleaseGroup do
  it_behaves_like 'a service'

  context 'with a valid blueprint' do
    # rubocop:disable RSpec/MultipleExpectations
    it 'prepares the artist-credit' do
      prepare_artist_credit_spy = spy
      proxy                     = spy

      args = {
        import_order:              :fake_import_order,
        import_request:            :fake_import_request,
        prepare_artist_credit_spy: prepare_artist_credit_spy,
        proxy:                     proxy
      }
      expect(MockPrepareBrainzReleaseGroup.call(args)).not_to be_nil
      expect(prepare_artist_credit_spy).to have_received(:call)
    end
    # rubocop:enable RSpec/MultipleExpectations
  end
end
