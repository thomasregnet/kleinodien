# frozen_string_literal: true

require 'rails_helper'

# Dummy class
class TestPersistablePrepareable
  include PersistablePrepareable
end

RSpec.describe PersistablePrepareable do
  context 'without having defined #persist_prepare_infix' do
    let(:noinfix) { TestPersistablePrepareable.new }

    it 'raises an MethodError' do
      expect { noinfix.persist_prepare_infix }
        .to raise_error(
          NoMethodError,
          /missed to implement.+persist_prepare_infix/
        )
    end
  end

  describe '#method_missing' do
    context 'when unable to take action' do
      let(:candidate) { TestPersistablePrepareable.new }

      it 'raises a NoMethodError' do
        expect { candidate.method_missing(:gizmo_dingus_maximus) }
          .to raise_error(
            NoMethodError,
            /undefined method `gizmo_dingus_maximus/
          )
      end
    end
  end
end
