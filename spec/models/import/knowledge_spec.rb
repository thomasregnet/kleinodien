require 'rails_helper'
require 'fake_reference'
require 'ko_test_data'

RSpec.describe Import::Knowledge do
  let(:knowledge) { described_class.new }

  context 'without parameters' do
    describe '#having' do
      it 'returns a Hash' do
        expect(knowledge.having).to be_instance_of(Hash)
      end

      specify 'the returned hash is empty' do
        expect(knowledge.having).to be_empty
      end
    end

    describe '#missing' do
      it 'returns a Hash' do
        expect(knowledge.missing).to be_instance_of(Set)
      end

      specify 'the returned hash is empty' do
        expect(knowledge.missing).to be_empty
      end
    end

    describe '#missing?' do
      it 'returns false' do
        expect(knowledge).not_to be_missing
      end
    end
  end

  context 'ask about something unknown' do
    before do
      @reference = FakeReference.from_code("abc")
      @knowledge = described_class.new
      @knowledge.about(@reference)
    end

    describe '#about!' do
      it 'raises an error' do
        expect { @knowledge.about!(reference) }
          .to raise_error(KnowledgeMissing)
      end
    end
    describe '#having' do
      it 'is empty' do
        expect(@knowledge.having).to be_empty
      end
    end

    describe '#missing' do
      it 'includes the reference' do
        expect(@knowledge.missing).to include(@reference)
      end
    end

    describe '#missing?' do
      it 'returns true' do
        expect(@knowledge).to be_missing
      end
    end
  end

  context 'ask about something known' do
    before do
      @reference = FakeReference.from_code('xyz')
      @knowledge = described_class.new(
        having: { @reference => 'foo' }
      )
    end

    describe '#about' do
      it 'returns the content' do
        expect(@knowledge.about(@reference)).to eq('foo')
      end
    end

    describe '#missing' do
      it 'is empty' do
        expect(@knowledge.missing).to be_empty
      end
    end
  end
end

# RSpec.describe Import::Knowledge do
#   context 'nothing known, nothing requested' do
#     let(:knowledge) { described_class.new({}) }

#     describe '#missing?' do
#       it 'returns false' do
#         expect(knowledge.missing?).to be false
#       end
#     end

#     describe '#brainz' do
#       it 'returns an Import::BrainzKnowledge instance' do
#         expect(knowledge.brainz).to be_instance_of(Import::BrainzKnowledge)
#       end
#     end

#     describe '#collect' do
#       it 'returns blank structures' do
#         collected = knowledge.collect
#         collected[:known].each_value do |knowledge_field|
#           expect(knowledge_field.length).to eq(0)
#         end

#         collected[:required].each_value do |knowledge_field|
#           expect(knowledge_field.length).to eq(0)
#         end
#       end
#     end
#   end

#   context 'nothing known, something requested' do
#     let(:knowledge) do
#       reference = FakeReference.new(code: 'abc')
#       knowledge = described_class.new
#       knowledge.brainz.about(reference)
#       knowledge
#     end

#     describe '#missing?' do
#       it 'returns true' do
#         expect(knowledge.missing?).to be true
#       end
#     end

#     describe '#collect' do
#       it 'has collected the requested data' do
#         collected = knowledge.collect
#         expect(collected.dig(:required, :brainz).length).to eq(1)
#       end
#     end
#   end

#   describe 'with some brainz knowledge' do
#     describe '#collect' do
#       it 'returns the known data' do
#         key = 'test/key'
#         xml = '<xml>fake</xml>'
#         knowledge = described_class.new(
#           known: {
#             brainz: {
#               key => xml
#             }
#           }
#         )

#         expect(knowledge.collect.dig(:known, :brainz, key)).to eq(xml)
#       end
#     end
#   end
# end
