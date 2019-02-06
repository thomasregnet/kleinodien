# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HeapTrack, type: :model do
  subject { FactoryBot.build(:heap_track) }

  it { is_expected.to belong_to(:heap) }
  it { is_expected.to belong_to(:import_order) }
  it { is_expected.to belong_to(:piece) }

  it { is_expected.to validate_presence_of(:heap) }
  it { is_expected.to validate_presence_of(:piece) }
  it { is_expected.to validate_presence_of(:position) }
end
