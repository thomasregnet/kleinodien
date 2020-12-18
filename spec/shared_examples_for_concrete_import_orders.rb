# frozen_string_literal: true

# A "concrete ImportOrder" is an ImportOrder that is written to the
# database and not just an abstract class.
# For example:
# * ImportOrder is the base class of all other import_orders
#   and not meant to be written to the database
# * BrainzImportOrder is the base class of other Brainz-import_orders
#   and also not meant to be written to the database
# * BrainzReleaseImportOrder is a concrete ImportOrder
#   meant to be written to the database
RSpec.shared_examples 'a concrete ImportOrder' do
  def factory
    @factory ||= described_class.to_s.underscore.to_sym
  end

  describe '#item and #item_designation' do
    %w[pending preparing persisting failed].each do |state|
      context "when state is \"#{state}\"" do
        let(:import_order) { FactoryBot.build(factory, state: state) }

        it 'has no item' do
          expect(import_order.item).to be_nil
        end

        it 'has no item_designation' do
          expect(import_order.item_designation).to be_nil
        end
      end
    end
  end
end