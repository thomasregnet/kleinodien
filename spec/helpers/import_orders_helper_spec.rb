# frozen_string_literal: true

require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ImportOrdersHelper. For example:
#
# describe ImportOrdersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ImportOrdersHelper, type: :helper do
  describe '#import_order_state_class_for' do
    context 'when the state is "pending"' do
      it 'returns "tag is-dark"' do
        expect(helper.import_order_state_class_for('pending')).to eq('tag is-dark')
      end
    end
  end

  context 'when the state is "preparing"' do
    it 'returns "tag is-primary is-light"' do
      expect(helper.import_order_state_class_for('preparing')).to eq('tag is-primary is-light')
    end
  end

  context 'when the state is "persisting"' do
    it 'returns "tag is-primary"' do
      expect(helper.import_order_state_class_for('persisting')).to eq('tag is-primary')
    end
  end

  context 'when the state is "done"' do
    it 'returns "tag is-success"' do
      expect(helper.import_order_state_class_for('done')).to eq('tag is-success')
    end
  end

  context 'when the state is "failed"' do
    it 'returns "tag is-danger"' do
      expect(helper.import_order_state_class_for('failed')).to eq('tag is-danger')
    end
  end

  context 'when the state is unknown' do
    it 'returns "tag is-danger"' do
      expect(helper.import_order_state_class_for('unknown')).to eq('tag is-danger')
    end
  end
end
