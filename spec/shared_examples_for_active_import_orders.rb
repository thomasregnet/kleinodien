# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'an active ImportOrder' do |factory|
  describe 'active ImportOrders must be unique' do
    let(:attributes) { FactoryBot.attributes_for(factory, state: 'pending') }
    let(:user) { FactoryBot.create(:user) }
    let(:import_order) { described_class.new(attributes.merge(user: user)) }

    before { described_class.create(attributes.merge(user: user)) }

    context 'with the same active state' do
      it 'is not valid' do
        expect(import_order).not_to be_valid
      end

      it 'must be unique' do
        expect { import_order.save!(validate: false) }
          .to raise_error(ActiveRecord::RecordNotUnique)
      end
    end

    context 'with a different active state' do
      before { import_order.state = :persisting }

      it 'is not valid' do
        expect(import_order).not_to be_valid
      end

      it 'must be unique' do
        expect { import_order.save!(validate: false) }
          .to raise_error(ActiveRecord::RecordNotUnique)
      end
    end

    context 'with a inactive state' do
      before { import_order.state = :done }

      it 'is valid' do
        expect(import_order).to be_valid
      end

      it 'must be unique' do
        expect { import_order.save!(validate: false) }
          .not_to raise_error
      end
    end
  end

  describe 'active import_orders do not care about inactive ones' do
    let(:attributes) { FactoryBot.attributes_for(factory) }
    let(:user) { FactoryBot.create(:user) }

    before do
      described_class.create(attributes.merge(state: 'done', user: user))
      described_class.create(attributes.merge(state: 'failed', user: user))
    end

    context 'when pending' do
      let(:import_order) { described_class.new(attributes.merge(state: 'pending', user: user)) }

      it 'is not valid' do
        expect(import_order).to be_valid
      end

      it 'must be unique' do
        expect { import_order.save!(validate: false) }.not_to raise_error
      end
    end

    context 'when preparing' do
      let(:import_order) { described_class.new(attributes.merge(state: 'preparing', user: user)) }

      it 'is not valid' do
        expect(import_order).to be_valid
      end

      it 'must be unique' do
        expect { import_order.save!(validate: false) }.not_to raise_error
      end
    end

    context 'when persisting' do
      let(:import_order) { described_class.new(attributes.merge(state: 'persisting', user: user)) }

      it 'is not valid' do
        expect(import_order).to be_valid
      end

      it 'must be unique' do
        expect { import_order.save!(validate: false) }.not_to raise_error
      end
    end
  end
end
