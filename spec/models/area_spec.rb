# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_areas'

RSpec.describe Area, type: :model do
  it_behaves_like 'an area'
end
