# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_unique_names'

RSpec.describe Company, type: :model do
  it_behaves_like 'an entity with an unique name' do
    let(:candidate) { FactoryBot.build(:company) }
  end

  subject { described_class.new(name: 'some company') }

  it { should belong_to(:area).optional }

  it { should respond_to(:sort_name) }
  it { should respond_to(:brainz_code) }
  it { should respond_to(:discogs_code) }
  it { should respond_to(:label_code) }
  it { should respond_to(:tmdb_code) }
  it { should respond_to(:wikidata_code) }
end
