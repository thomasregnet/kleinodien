require 'rails_helper'

RSpec.describe TestData::Subset do
  describe '#add' do
    let(:brainz_code) { '7452f8c9-f9bc-3ca7-859e-3220e57e4e4a' }
    let(:subset) { described_class.new }

    context 'valid data' do
      it 'returns the right reference' do
        expect(subset.add(:brainz_release, brainz_code))
          .to be_instance_of(BrainzReleaseReference)
      end
    end

    describe '#to_hash' do
      it 'returns a hash of the data' do
        subset.add(:brainz_release, brainz_code)
        #subset.to_hash[:brainz].each_value do |xml|
        subset.to_hash.each_value do |xml|
          expect(xml).to match(/^<\?xml/)
        end
      end
    end
  end
end
