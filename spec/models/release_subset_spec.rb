# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReleaseSubset, type: :model do
  it { is_expected.to belong_to(:release) }
  it { is_expected.to have_many(:tracks) }
  it { is_expected.to validate_presence_of(:no) }
end
