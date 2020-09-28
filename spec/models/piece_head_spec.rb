# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_code_findable'
require 'shared_examples_for_models_with_credits'
require 'shared_examples_for_models_with_labels'
require 'shared_examples_for_disambiguations'
require 'shared_examples_for_rateable_models'
require 'shared_examples_for_sources'
require 'shared_examples_for_tagable_models'

RSpec.describe PieceHead, type: :model do
  let(:piece_head) { FactoryBot.build(:piece_head) }

  it { is_expected.to belong_to(:import_order).without_validating_presence }

  it_behaves_like 'a code findable entity' do
    before { DatabaseCleaner.start }

    let(:factory) { :piece_head }
    after { DatabaseCleaner.clean }
  end

  it 'is valid with valid attributes' do
    expect(piece_head).to be_valid
  end

  it_behaves_like 'a rateable model' do
    let(:rateable) { FactoryBot.create(:piece_head) }
  end

  it_behaves_like 'a tagable model' do
    let(:tagable) { piece_head }
  end

  it 'is not valid without a type' do
    piece_head = FactoryBot.build(:piece_head)
    piece_head.type = nil
    expect(piece_head).not_to be_valid
  end

  it_behaves_like 'a model with credits' do
    let(:candidate) { FactoryBot.create(:piece_head_with_credits) }
  end

  it_behaves_like 'a model with labels' do
    let(:candidate) { FactoryBot.create(:piece_head_with_labels) }
  end

  it_behaves_like 'a model with disambiguations' do
    let(:factory) { :piece_head }
    let(:object) { FactoryBot.build(:piece_head) }
    let(:naming) { 'title' }
  end

  it_behaves_like 'an object with a source' do
    let(:candidate) { FactoryBot.create(:piece_head) }
  end
end
