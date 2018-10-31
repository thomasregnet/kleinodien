# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_import_orders'

RSpec.describe ImportOrder, type: :model do
  include_examples 'for ImportOrders', :import_order
end
