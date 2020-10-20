# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MediumFormat, type: :model do
  it { should respond_to(:name) }
  it { should respond_to(:explanation) }
  it { should respond_to(:year) }
  it { should respond_to(:brainz_code) }
  it { should respond_to(:import_order) }

  describe 'two medium_formats with minimal values' do
    # 
  end

  describe '#brainz_code' do
    subject { FactoryBot.create(:medium_format_with_brainz_code) }

    it { should have_db_index(:brainz_code).unique(true) }
    it { should validate_uniqueness_of(:brainz_code).ignoring_case_sensitivity.allow_nil }
  end

  describe '#release_media' do
    # it { should have_many(:release_media) }
    it { should have_many(:media) }
  end

  describe '#import_order' do
    it { should belong_to(:import_order).without_validating_presence }
  end

  describe '#name' do
    subject { FactoryBot.create(:medium_format) }

    it { should have_db_index(:name).unique(true) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end
end
