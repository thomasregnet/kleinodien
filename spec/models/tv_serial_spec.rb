# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_disambiguations'

RSpec.describe TvSerial, type: :model do
  context 'without seasons' do
    let(:tv_serial) { FactoryBot.create(:tv_serial) }

    it 'is valid with valid attributes' do
      expect(tv_serial).to be_valid
    end

    it_behaves_like 'a model with disambiguations' do
      let(:factory) { :tv_serial }
      let(:object) { tv_serial }
      let(:naming) { 'title' }
    end
  end

  context 'with seassons' do
    let(:tv_serial) do
      FactoryBot.create(:tv_serial_with_seasons, seasons_count: 3)
    end

    it 'has seasons' do
      expect(tv_serial.seasons.count).to eq(3)
    end
  end
end
