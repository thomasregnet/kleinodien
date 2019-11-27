# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

RSpec.describe PrepareBrainzDataService do
  it_behaves_like 'a service'

  # the specs for the service belongs here

  context 'with a length' do
    let(:prepared) do
      described_class.call(brainz_data: { length: '123' })
    end

    it 'has set the milliseconds' do
      expect(prepared[:milliseconds]).to eq(123)
    end
  end
end
