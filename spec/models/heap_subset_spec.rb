# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HeapSubset, type: :model do
  it { is_expected.to belong_to(:heap) }
  it { is_expected.to have_many(:tracks) }
  it { is_expected.to validate_presence_of(:no) }
end
