# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_import_orders'
require 'shared_examples_for_import_queue_name'
require 'shared_examples_for_code_uuid_validations'

RSpec.describe BrainzImportOrder, type: :model do
  include_examples 'for ImportOrders', :brainz_import_order
  include_examples(
    'for #import_queue_name', :brainz_import_order, 'brainz_import_orders_queue'
  )
  include_examples 'for code fields that must be an uuid', :brainz_import_order
end
