# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_code_findable'
require 'shared_examples_for_disambiguations'
require 'shared_examples_for_rateable_models'
require 'shared_examples_for_tagable_models'

RSpec.describe Serial, type: :model do
  it 'is valid with valid parameters' do
    expect(FactoryBot.build(:serial)).to be_valid
  end

  it_behaves_like 'a code findable entity' do
    before { DatabaseCleaner.start }

    let(:factory) { :serial }
    after { DatabaseCleaner.clean }
  end

  it_behaves_like 'a rateable model' do
    let(:rateable) { FactoryBot.build(:serial) }
  end

  it_behaves_like 'a tagable model' do
    let(:tagable) { FactoryBot.build(:serial) }
  end

  context 'without seasons' do
    it_behaves_like 'a model with disambiguations' do
      let(:factory) { :serial }
      let(:object) { FactoryBot.build(:serial) }
      let(:naming) { 'title' }
    end
  end
end
