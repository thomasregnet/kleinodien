# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'
require 'test_data'

RSpec.describe PersistBrainzCompany do
  it_behaves_like 'a service'

  describe 'persist the company' do
    let(:brainz_company) do
      TestData.by_name(:brainz_label_alternative_tentacles).blueprint
    end
    let(:import_order) { FactoryBot.build(:brainz_release_import_order) }
    let(:proxy) { spy }

    before do
      allow(proxy).to receive(:get).and_return(brainz_company)
      described_class.call(
        blueprint:    brainz_company,
        import_order: import_order,
        proxy:        proxy
      )
    end

    it 'has persisted the company' do
      expect(Company.find_by(name: 'Alternative Tentacles'))
        .to be_instance_of(Company)
    end
  end
end
