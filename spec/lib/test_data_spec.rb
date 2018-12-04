# frozen_string_literal: true

require 'rails_helper'
require 'test_data'

RSpec.describe TestData do
  it { is_expected.to respond_to(:by_name) }
end
