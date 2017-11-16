require 'rails_helper'
require 'fake_reference'
require 'ko_test_data'

RSpec.describe Import::Knowledge do
  context 'knows nothing' do
    context 'nothing requested' do
      let(:knowledge) { described_class.new({}) }

      describe '#missing?' do
        it 'returns false' do
          expect(knowledge.missing?).to be false
        end
      end

      describe '#brainz' do
        it 'returns an Import::BrainzKnowledge instance' do
          expect(knowledge.brainz).to be_instance_of(Import::BrainzKnowledge)
        end
      end

      describe '#collect' do
        it 'returns a blank structure' do
          expect(knowledge.collect.length).to be > 0
          knowledge.collect.each_value do |knowledge_field|
            expect(knowledge_field[:known].length).to eq(0)
            expect(knowledge_field[:required].length).to eq(0)
          end
        end
      end

      context 'something requested' do
        before(:context) do
          @reference = FakeReference.new(code: 'abc')
          @knowledge = described_class.new({})
          @knowledge.brainz.about(@reference)
        end

        describe '#missing' do
          it 'returns true' do
            expect(@knowledge.missing?).to be true
          end
        end

        describe '#collect' do
          it 'has collected the requested data' do
            collected = @knowledge.collect
            expect(collected[:brainz][:required]).to include(@reference.to_key)
          end
        end
      end
    end

    describe 'with some brainz knowledge' do
      describe '#collect' do
        before(:context) do
          brainz_id = '5fc9ba9d-bc39-38fc-a479-eadbf0f3a933'
          @reference = BrainzReleaseGroupRef.new(code: brainz_id)
          @xml = KoTestData.brainz_xml_for(@reference)
          known = {
            brainz: {
              @reference.to_key => @xml
            }
          }
          @knowledge = described_class.new(known: known)
        end

        it 'returns the known data' do
          expect(@knowledge.collect[:brainz][:known][@reference.to_key])
            .to eq(@xml)
        end
      end
    end

    context 'something requested' do
      before(:each) do
        @knowledge = described_class.new
      end
    end
  end
end
