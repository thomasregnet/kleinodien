# frozen_string_literal: true

require 'fake_proxy'
require 'rails_helper'
require 'shared_examples_for_services'
require 'test_data'

RSpec.describe PersistBrainzCompany do
  it_behaves_like 'a service'

  describe 'persist the company' do
    let(:brainz_label) do
      TestData.by_name(:brainz_label_alternative_tentacles).blueprint
    end

    let(:brainz_area) do
      TestData.by_name(:brainz_area_germany).blueprint
    end

    let(:import_order) { FactoryBot.build(:brainz_release_import_order) }
    let(:proxy) { FakeProxy.new }

    before do
      described_class.call(
        code:         brainz_label.brainz_code,
        import_order: import_order,
        proxy:        proxy
      )
    end

    it 'has persisted the company' do
      expect(Company.find_by(name: 'Alternative Tentacles'))
        .to be_instance_of(Company)
    end

    it 'has persisted the area of the company' do
      expect(Area.find_by(name: 'San Francisco')).not_to be_nil
    end
  end

  context 'when the Company has no area' do
    let(:brainz_label) do
      TestData.by_name(:brainz_label_noise).blueprint
    end
    let(:import_order) { FactoryBot.build(:brainz_release_import_order) }
    let(:proxy) { FakeProxy.new }

    before do
      brainz_label.delete :area
      described_class.call(
        code:         brainz_label.brainz_code,
        import_order: import_order,
        proxy:        proxy
      )
    end

    it 'has persisted the company' do
      expect(Company.find_by(name: 'Noise'))
        .to be_instance_of(Company)
    end
  end
end
