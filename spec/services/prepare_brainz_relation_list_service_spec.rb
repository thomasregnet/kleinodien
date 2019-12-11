# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

# rubocop:disable Metrics/BlockLength
RSpec.describe PrepareBrainzRelationListService do
  it_behaves_like 'a service'

  context 'with a relation-key containing a single hash' do
    let(:relation_list) do
      {
        'relation' => {},
        'target_type' => 'gizmo'
      }
    end

    let(:prepared) { described_class.call(relation_list: relation_list) }

    it 'returns a hash with one key' do
      expect(prepared.length).to eq(1)
    end

    it 'returns a hash with the expected key' do
      expect(prepared).to have_key('gizmo_relations')
    end

    it 'returns a hash-value containing an array' do
      expect(prepared['gizmo_relations']).to be_instance_of(Array)
    end

    it 'returns a hash-value containing the expected number of items' do
      expect(prepared['gizmo_relations'].length).to eq(1)
    end
  end

  context 'with a relation-key containing an array of hashes' do
    let(:relation_list) do
      {
        'relation' => [{}, {}],
        'target_type' => 'gizmo'
      }
    end

    let(:prepared) { described_class.call(relation_list: relation_list) }

    it 'returns a hash with one key' do
      expect(prepared.length).to eq(1)
    end

    it 'returns a hash with the expected key' do
      expect(prepared).to have_key('gizmo_relations')
    end

    it 'returns a hash-value containing an array' do
      expect(prepared['gizmo_relations']).to be_instance_of(Array)
    end

    it 'returns a hash-value containing the expected number of items' do
      expect(prepared['gizmo_relations'].length).to eq(2)
    end
  end
end
# rubocop:enable Metrics/BlockLength
