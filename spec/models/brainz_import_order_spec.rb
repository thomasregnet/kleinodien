# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_import_orders'

RSpec.describe BrainzImportOrder, type: :model do
  include_examples 'for ImportOrders', :brainz_import_order

  context 'no uuid as code' do
    let(:import_order) { FactoryBot.build(:brainz_import_order, code: 'abc') }

    it 'is not valid' do
      expect(import_order).not_to be_valid
    end
  end
end
