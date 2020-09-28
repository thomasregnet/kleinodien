# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_disambiguations'
require 'shared_examples_for_rateable_models'
require 'shared_examples_for_tagable_models'

RSpec.describe Station, type: :model do
  it_behaves_like 'a rateable model' do
    let(:rateable) { FactoryBot.build(:station) }
  end

  it_behaves_like 'a tagable model' do
    let(:tagable) { FactoryBot.build(:station) }
  end

  it 'is valid with valid parameters' do
    expect(FactoryBot.build(:station)).to be_valid
  end

  it_behaves_like 'a model with disambiguations' do
    let(:factory) { :station }
    let(:object) { FactoryBot.build(:station) }
    let(:naming) { 'name' }
  end
end
