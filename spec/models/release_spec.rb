# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Release, type: :model do
  it { is_expected.to belong_to(:artist_credit).without_validating_presence }
  it { is_expected.to belong_to(:head).class_name('ReleaseHead') }
  it { is_expected.to belong_to(:import_order).without_validating_presence }
  it { is_expected.to have_many(:media) }
  it { is_expected.to have_many(:release_events) }
  it { is_expected.to have_many(:subsets) }

  context 'with valid attributes' do
    let(:release) { FactoryBot.build(:release) }

    it 'is valid' do
      expect(release).to be_valid
    end
  end

  describe '#head' do
    let(:release) { FactoryBot.build(:release) }

    context 'when nil' do
      it 'is not valid' do
        release.head = nil
        expect(release).not_to be_valid
      end
    end
  end
end
