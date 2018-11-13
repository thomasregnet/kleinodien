# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

RSpec.describe ImportBrainzRelease do
  it_behaves_like 'a service'
end
