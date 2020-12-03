# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

RSpec.describe ImportBrainzRelease do
  it_behaves_like 'a service'

  def brainz_code
    'ad6f9162-e8b2-11e8-8a59-abffd0f2862f'
  end

  def import_order_args
    { code: brainz_code }
    # { code: brainz_code, kind: :release }
  end

  context 'when the requested import already exists' do
    before do
      DatabaseCleaner.start
      FactoryBot.create(:release, brainz_code: brainz_code)
    end

    after { DatabaseCleaner.clean }

    let(:import_order) do
      FactoryBot.build(:brainz_import_order, import_order_args)
    end

    specify 'the :result contains the release' do
      expect(described_class.call(import_order: import_order))
        .to be_instance_of Release
    end

    specify ':new_record is false' do
      expect(described_class.call(import_order: import_order).created?)
        .to be false
    end
  end

  context 'when importing "Walls of Jericho"' do
    let(:import_order) do
      FactoryBot.create(:brainz_release_import_order, code: 'a97ff185-7acc-3382-bbe1-0155ab3caab0')
    end

    it 'returns the imported release' do
      expect(described_class.call(import_order: import_order)).to be_instance_of(Album)
    end
  end
end
