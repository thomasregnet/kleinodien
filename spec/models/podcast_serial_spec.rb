# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_disambiguations'

RSpec.describe PodcastSerial, type: :model do
  context 'without season' do
    before do
      @podcast_serial = FactoryBot.create(:podcast_serial)
    end

    it 'is valid with valid attributes' do
      expect(@podcast_serial).to be_valid
    end

    it_behaves_like 'a model with disambiguations' do
      let(:factory) { :podcast_serial }
      let(:object) { @podcast_serial }
      let(:naming) { 'title' }
    end
  end
end
