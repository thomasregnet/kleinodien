# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_area_aliases'
require 'support/shared_examples_for_periodable_models'

RSpec.describe AreaAlias, type: :model do
  subject { FactoryBot.build(:area_alias) }

  it_behaves_like 'an area alias'
  it_behaves_like 'a periodable model'
end
