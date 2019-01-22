# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_import_orders'

RSpec.describe ImportOrder, type: :model do
  include_examples 'for ImportOrders', :import_order

  it { is_expected.to have_many(:heap_heads) }

  it 'has a counter_cache for import_requests' do
    request_args = {
      type: 'BrainzArtistImportRequest',
      code: 'b65a263c-f3c7-11e8-a665-7be5100d3866'
    }
    import_order = FactoryBot.create(:brainz_import_order)
    import_order.import_requests.create(request_args)
    expect(import_order.requests_count).to eq(1)
  end
end
