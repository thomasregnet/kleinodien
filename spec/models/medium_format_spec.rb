# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MediumFormat, type: :model do
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:explanation) }
  it { is_expected.to respond_to(:year) }
  it { is_expected.to respond_to(:brainz_code) }
  it { is_expected.to respond_to(:import_order) }

  it { is_expected.to belong_to(:import_order).without_validating_presence }

  it { is_expected.to have_many(:heap_media) }

  it { is_expected.to validate_presence_of(:name) }
end
