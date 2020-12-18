# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_active_import_orders'
require 'shared_examples_for_import_orders'

RSpec.describe BrainzReleaseImportOrder, type: :model do
  it { should respond_to(:item_designation) }

  it_behaves_like 'an active ImportOrder', :brainz_release_import_order
  it_behaves_like 'an ImportOrder', :brainz_release_import_order
end
