# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_code_findable'
require 'shared_examples_for_models_with_duration'
# require 'shared_examples_for_incomplete_dates'
require 'shared_examples_for_rateable_models'
require 'shared_examples_for_tagable_models'
require 'support/shared_examples_for_dateable_models'

RSpec.describe Piece, type: :model do
  subject { FactoryBot.build(:piece) }

  it_behaves_like 'a dateable model'

  it { is_expected.to belong_to(:import_order).without_validating_presence }
  it { is_expected.to have_many(:release_tracks) }
  it { is_expected.to have_many(:piece_tracks) }

  it_behaves_like 'a code findable entity' do
    before { DatabaseCleaner.start }

    let(:factory) { :piece }
    after { DatabaseCleaner.clean }
  end

  it_behaves_like 'a model with duration'

  it_behaves_like 'a rateable model' do
    let(:rateable) { FactoryBot.build(:piece) }
  end

  it_behaves_like 'a tagable model' do
    let(:tagable) { FactoryBot.build(:piece) }
  end

  context 'without tracks' do
    let(:piece) { FactoryBot.build(:piece_with_head) }

    it 'is valid with valid attributes' do
      expect(piece).to be_valid
    end
  end

  # it_behaves_like 'a model with an IncompleteDate' do
  #   let(:candidate) { FactoryBot.create(:piece) }
  #   let(:date_naming) { 'date' }
  # end
end
