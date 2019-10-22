# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

RSpec.describe FindOrCreateAreaByNameService do
  it_behaves_like 'a service'

  context 'when the area exists' do
    # We use the :brainz_code here to make sure we get the area
    # we have created just before.
    let(:name) { 'Lost Kingdom' }
    let(:brainz_code) { '71fa80be-f500-11e9-ace8-5bee5e9ce873' }

    before { Area.create(name: name, brainz_code: brainz_code) }

    it 'returns that area' do
      expect(described_class.call(name: name).brainz_code).to eq(brainz_code)
    end
  end

  context 'when the area does not exist' do
    let(:name) { 'Lost Kingdom' }

    it 'creates the area' do
      expect(described_class.call(name: name)).to be_instance_of(Area)
    end
  end
end
