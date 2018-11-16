# frozen_string_literal: true

require 'rails_helper'
require 'ko_test_data'

RSpec.describe BrainzBaseBlueprint do
  describe 'relations' do
    context 'with no relations'

    context 'with one relation list'

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
