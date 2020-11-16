# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_models_having_many_images'

RSpec.describe Release, type: :model do
  it_behaves_like 'a model having many images'

  it { should belong_to(:area).without_validating_presence }
  it { should belong_to(:artist_credit).without_validating_presence }
  it { should belong_to(:head).class_name('ReleaseHead') }
  it { should belong_to(:import_order).without_validating_presence }
  it { should belong_to(:language).without_validating_presence }
  it { should belong_to(:script).without_validating_presence }

  it { should have_many(:media) }
  it { should have_many(:release_companies) }
  it { should have_many(:release_events) }
  it { should have_many(:subsets) }

  it { should respond_to(:front_cover) }

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
