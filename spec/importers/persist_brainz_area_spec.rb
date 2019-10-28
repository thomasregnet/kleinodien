# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'
require 'test_data'

RSpec.describe PersistBrainzArea do
  it_behaves_like 'a service'

  describe 'persists the area' do
    let(:brainz_area) { TestData.by_name(:brainz_area_germany).blueprint }
    let(:import_order) { spy }
    let(:proxy) { spy }

    before do
      allow(proxy).to receive(:get).and_return(brainz_area)
      described_class.call(
        blueprint:    brainz_area,
        import_order: import_order,
        proxy:        proxy
      )
    end

    it 'has persisted the area' do
      expect(Area.find_by(name: 'Germany').name).to eq('Germany')
    end
  end
end
