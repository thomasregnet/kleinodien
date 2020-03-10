# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_persister_and_preparer_base_classes'

RSpec.describe PersistBrainzBase do
  it_behaves_like 'a persister/preparer base-class'
end
