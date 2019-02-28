# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_models_with_duration'

RSpec.describe HeapTrack, type: :model do
  # subject { FactoryBot.build(:heap_track) }

  it { is_expected.to belong_to(:subset) }
  it { is_expected.to belong_to(:import_order).without_validating_presence }
  it { is_expected.to belong_to(:piece) }

  it { is_expected.to validate_presence_of(:no) }
  it { is_expected.to validate_presence_of(:piece) }

  it_behaves_like 'a model with duration'
end
