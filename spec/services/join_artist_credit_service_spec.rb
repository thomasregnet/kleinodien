# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

RSpec.describe JoinArtistCreditService do
  it_behaves_like 'a service'

  describe '.call' do
    context 'without special parameters' do
      it 'returns the joined names' do
        candidates = [
          instance_double('To be joined', name: 'A', join_phrase: '&'),
          instance_double('To be joined', name: 'B', join_phrase: nil)
        ]

        expect(described_class.call(candidates: candidates))
          .to eq('A & B')
      end
    end

    context 'with a "name_method" parameter' do
      it 'returns the joined names' do
        candidates = [
          instance_double('To be joined', title: 'A', join_phrase: 'and'),
          instance_double('To be joined', title: 'B', join_phrase: nil)
        ]
        args = { candidates: candidates, name_method: :title }

        expect(described_class.call(args)).to eq('A and B')
      end
    end
  end
end
