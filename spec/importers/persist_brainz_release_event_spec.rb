# frozen_string_literal: true

require 'fake_proxy'
require 'rails_helper'
require 'shared_examples_for_services'
require 'test_data'

RSpec.describe PersistBrainzReleaseEvent do
  it_behaves_like 'a service'

  describe 'it persists the ReleaseEvent' do
    let(:release) do
      TestData.by_name(:brainz_release_powerslave_enhanced_cd).blueprint
    end

    let(:release_event) { release.release_events.first }
    let(:area) { release_event.area }
    let(:proxy) { FakeProxy.new }

    let(:args) do
      {
        import_order: FactoryBot.create(:brainz_release_import_order),
        proxy:        proxy,
        blueprint:    release_event,
        release:      FactoryBot.create(:release)
      }
    end

    it 'persists the ReleaseEvent' do
      expect(described_class.call(args)).to be_instance_of(ReleaseEvent)
    end
  end
end
