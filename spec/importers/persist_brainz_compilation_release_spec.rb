# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

RSpec.describe PersistBrainzCompilationRelease do
  it_behaves_like 'a service'
end
