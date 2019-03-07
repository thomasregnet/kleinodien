# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MediumFormat, type: :model do
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:explanation) }
  it { is_expected.to respond_to(:year) }
  it { is_expected.to respond_to(:brainz_code) }
  it { is_expected.to respond_to(:import_order) }

  describe '#brainz_code' do
    subject { FactoryBot.create(:medium_format_with_brainz_code) }

    it { is_expected.to have_db_index(:brainz_code).unique(true) }
    it { should validate_uniqueness_of(:brainz_code).ignoring_case_sensitivity }
  end

  describe '#heap_media' do
    it { is_expected.to have_many(:heap_media) }
  end

  describe '#import_order' do
    it { is_expected.to belong_to(:import_order).without_validating_presence }
  end

  describe '#name' do
    subject { FactoryBot.create(:medium_format) }

    it { is_expected.to have_db_index(:name).unique(true) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end
