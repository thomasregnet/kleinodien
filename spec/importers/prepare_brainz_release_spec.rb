# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'
require 'test_data'

# Mock calls to other classes
class MockPrepareBrainzRelease < PrepareBrainzRelease
  def initialize(prepare_artist_credit_spy:, prepare_release_group_spy:, **args)
    @prepare_artist_credit_spy = prepare_artist_credit_spy
    @prepare_release_group_spy = prepare_release_group_spy
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

# rubocop:disable Metrics/BlockLength
RSpec.describe PrepareBrainzRelease do
  it_behaves_like 'a service'

  describe '.call' do
    context 'when the release is not already persisted' do
      let(:blueprint) do
        TestData.by_name(:brainz_release_arise_jp_cd).blueprint
      end

      it 'returns true' do
        prepare_artist_credit_spy = spy
        prepare_release_group_spy = spy
        proxy                     = spy
        args = {
          blueprint:                 blueprint,
          prepare_artist_credit_spy: prepare_artist_credit_spy,
          prepare_release_group_spy: prepare_release_group_spy,
          proxy:                     proxy
        }
        expect(MockPrepareBrainzRelease.call(args)).to be(true)
      end
    end
  end

  describe '#prepare_artist_credit' do
    context 'when the artist_credist does not exist' do
      let(:preparer) do
        xml_string = TestData.by_name(:brainz_release_arise_jp_cd).raw
        described_class.new(
          blueprint: BrainzBlueprint.from_xml(xml_string),
          proxy:     spy
        )
      end

      it 'returns a true value' do
        expect(preparer.prepare_artist_credit).not_to be_nil
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
