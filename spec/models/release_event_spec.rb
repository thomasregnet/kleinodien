# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_incomplete_dates'

RSpec.describe ReleaseEvent, type: :model do
  it { should belong_to(:area) }
  it { should belong_to(:release) }

  describe 'with valid parameters' do
    let(:release_event) { FactoryBot.build(:release_event) }

    it 'is valid' do
      expect(release_event).to be_valid
    end

    it 'can be saved' do
      expect(release_event.save).to be_truthy
    end
  end

  # describe '#date' do
  #   it_behaves_like 'a model with an IncompleteDate' do
  #     let(:candidate) { FactoryBot.build(:release_event) }
  #     let(:date_naming) { 'date' }
  #   end
  # end
end
