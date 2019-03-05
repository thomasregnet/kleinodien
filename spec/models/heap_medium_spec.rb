# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HeapMedium, type: :model do
  it { is_expected.to respond_to(:position) }
  it { is_expected.to respond_to(:quantity) }
  it { is_expected.to respond_to(:medium_format) }
  it { is_expected.to respond_to(:heap) }
end
