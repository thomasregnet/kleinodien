# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

RSpec.describe ImportBrainzRelease do
  it_behaves_like 'a service'

  it 'raises without a BrainzImportOrder'
  it 'raises if the kind is not "release"'

  it 'initializes the store'
  it 'calls PrepareBrainzRelease'
  it 'calls PersistBrainzRelease'

  it 'persists within a transaction'
end
