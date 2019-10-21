# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_area_aliases'

RSpec.describe AreaAlias, type: :model do
  it_behaves_like 'an area alias'
end
