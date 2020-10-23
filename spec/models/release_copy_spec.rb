# frozen_string_literal: true

require 'rails_helper'
require 'support/shared_examples_for_release_copies'

RSpec.describe ReleaseCopy, type: :model do
  subject { FactoryBot.build(:release_copy, release: FactoryBot.build(:release)) }

  it_behaves_like 'a ReleaseCopy'
end
