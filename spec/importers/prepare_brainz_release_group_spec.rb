# frozen_string_literal: true

require 'rails_helper'
require 'test_data'
require 'shared_examples_for_services'

# Mock prepare_* calls
class MockPrepareBrainzReleaseGroup < PrepareBrainzReleaseGroup
  def initialize(args)
    @prepare_artist_credit_spy = args[:prepare_artist_credit_spy]
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
    let(:blueprint) do
      # KoTestData::GetBrainzBlueprintFor.path(
      #   'release-group/5fc9ba9d-bc39-38fc-a479-eadbf0f3a933' \
      #     '?inc=artists+artist-rels+label-rels+url-rels.xml'
      # )
      TestData.by_name(:brainz_release_group_arise).blueprint
    end

    it 'prepares the artist-credit' do
      prepare_artist_credit_spy = spy
      proxy                     = spy

      args = {
        blueprint:                 blueprint,
        prepare_artist_credit_spy: prepare_artist_credit_spy,
        proxy:                     proxy
      }
      expect(MockPrepareBrainzReleaseGroup.call(args)).to be_nil
      expect(prepare_artist_credit_spy).to have_received(:call)
    end
  end
end
