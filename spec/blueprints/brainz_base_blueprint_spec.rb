# frozen_string_literal: true

require 'rails_helper'
require 'ko_test_data'

RSpec.describe BrainzBaseBlueprint do
  describe 'relations' do
    context 'with no relations'

    context 'with one relation list' do
      let(:blueprint) do
        KoTestData::GetBrainzBlueprintFor.path(
          'artist/37e9d7b2-7779-41b2-b2eb-3685351caad3?inc=url-rels.xml'
        )
      end

      it 'returns the relation' do
        # expect(blueprint.relation_lists).to be_instance_of Hashie::Array
        expect(blueprint.relation_lists).to be_kind_of Hashie::Array
      end
    end

    context 'with two relation lists' do
      let(:blueprint) do
        KoTestData::GetBrainzBlueprintFor.path(
          'artist/bdacc37b-8633-4bf8-9dd5-4662ee651aec?' \
            'inc=artist-rels+url-rels.xml'
        )
      end

      it 'returns the url relations' do
        expect(blueprint.url_relations).to be_instance_of Hashie::Array
      end
    end
  end
end
