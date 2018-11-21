# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

class MockPrepareBrainzRelease < PrepareBrainzRelease
  def initialize(args)
    @prepare_artist_credit_spy = args[:prepare_artist_credit_spy]
    @prepare_release_group_spy = args[:prepare_release_group_spy]
    super(args)
  end

  attr_reader :prepare_artist_credit_spy, :prepare_release_group_spy

  def prepare_artist_credit
    prepare_artist_credit_spy.call
  end

  def prepare_release_group
    prepare_release_group_spy.call
  end
end

RSpec.describe PrepareBrainzRelease do
  it_behaves_like 'a service'

  describe '.call' do
    context 'when the release is not already persisted' do
      let(:import_request) do
        FactoryBot.build(
          :brainz_release_import_request,
          code: '7452f8c9-f9bc-3ca7-859e-3220e57e4e4a'
        )
      end

      it 'returns nil' do
        prepare_artist_credit_spy = spy
        prepare_release_group_spy = spy
        proxy                     = spy
        args = {
          prepare_artist_credit_spy: prepare_artist_credit_spy,
          prepare_release_group_spy: prepare_release_group_spy,
          import_request:            import_request,
          proxy:                     proxy
        }
        expect(MockPrepareBrainzRelease.call(args)).to be_nil
        expect(prepare_artist_credit_spy).to have_received(:call)
        expect(prepare_release_group_spy).to have_received(:call)
      end
    end
  end
end
