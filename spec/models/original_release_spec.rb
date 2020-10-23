# frozen_string_literal: true

require 'rails_helper'
require 'support/shared_examples_for_release_copies'

RSpec.describe OriginalRelease, type: :model do
  subject { FactoryBot.build(:original_release) }

  it_behaves_like 'a ReleaseCopy'
end
