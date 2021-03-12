# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_areas'
require 'support/shared_examples_for_periodable_models'

RSpec.describe Area, type: :model do
  subject { FactoryBot.build(:area) }

  it_behaves_like 'an area'
  it_behaves_like 'a periodable model'
end
