require 'rails_helper'

RSpec.describe Import::Knowledge do
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
  end

  context 'something requested' do
    before(:each) do
      @knowledge = described_class.new
    end
  end
end
