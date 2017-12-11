require 'rails_helper'
require 'ko_test_data'
require 'shared_examples_for_knowledge_field'

RSpec.describe Import::BrainzKnowledge do
  it_behaves_like 'a knowledge field'

  context 'with knowledge' do
    before(:each) do
      @reference = BrainzArtistReference.from_code(
        '2280ca0e-6968-4349-8c36-cb0cbd6ee95f'
      )
      ref_key = @reference.to_key
      @knowledge = Import::BrainzKnowledge.new(
        known: {
          ref_key => KoTestData.brainz_xml_for(@reference)
        }
      )
    end

    describe '#about' do
      it 'returns a MashedBrainz instance' do
        expect(@knowledge.about(@reference)).to be_instance_of(MashedBrainz::Artist)
      end
    end
  end
end
