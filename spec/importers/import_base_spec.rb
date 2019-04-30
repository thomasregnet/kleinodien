# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

RSpec.describe ImportBase do
  it_behaves_like 'a service'

  context 'with an invalid ImportOrder' do
    it 'raises an ArgumentError' do
      import_order = instance_double('ImportOrder')
      allow(import_order).to receive('valid?').and_return(false)

      expect { described_class.call(import_order: import_order) }
        .to raise_error(ArgumentError)
    end
  end

  describe '#find_already_existing' do
    let(:base) { described_class.new({}) }

    it 'raises an NoMethodError' do
      expect { base.find_already_existing }
        .to raise_error(
          NoMethodError,
          /Class.+does not implement `find_already_existing'\Z/
        )
    end
  end

  describe '#prepare' do
    let(:base) { described_class.new({}) }

    it 'raises an NoMethodError' do
      expect { base.prepare }
        .to raise_error(
          NoMethodError,
          /Class.+does not implement `prepare'\Z/
        )
    end
  end

  describe '#persist' do
    let(:base) { described_class.new({}) }

    it 'raises an NoMethodError' do
      expect { base.persist }
        .to raise_error(
          NoMethodError,
          /Class.+does not implement `persist'\Z/
        )
    end
  end
end
