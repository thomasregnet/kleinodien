# frozen_string_literal: true

require 'rails_helper'
require 'fake_reference'

RSpec.describe Import::OfferKnowledge do
  let(:knowledge) { described_class.new }

  describe 'add_with_reference' do
    let(:reference) { FakeReference.new(code: 'abc') }
    let(:data) { '<fake data>' }

    it 'stores the data in the category of the reference' do
      knowledge.add_with_reference(reference, data)
      expect(knowledge.collect.dig(:fake_catagory)[reference.to_key])
        .to eq '<fake data>'
    end
  end
end
