# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HeapMedium, type: :model do
  it { is_expected.to respond_to(:position) }
  it { is_expected.to respond_to(:quantity) }
  it { is_expected.to respond_to(:format) }
  it { is_expected.to respond_to(:heap) }

  it { is_expected.to validate_presence_of(:position) }
  it { is_expected.to validate_presence_of(:quantity) }
end
