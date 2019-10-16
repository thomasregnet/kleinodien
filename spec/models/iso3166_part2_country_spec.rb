# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_iso_3166_models'

RSpec.describe Iso3166Part2Country, type: :model do
  it_behaves_like 'an ISO-3166 model' do
    let(:good_code) { 'DE-BY' }
  end

  describe '#code' do
    context 'when invalid' do
      let(:iso) { FactoryBot.build(:iso3166_part2_country, code: '123-zzz') }

      it 'is not valid' do
        expect(iso).not_to be_valid
      end
    end
  end
end
