require 'rails_helper'

RSpec.describe TestSubset do
  describe '#add' do
    let(:subset) { described_class.new }
    context 'valid data' do
      let(:brainz_code) { '7452f8c9-f9bc-3ca7-859e-3220e57e4e4a' }

      it 'returns the right reference' do
        expect(subset.add(:brainz_release, :brainz_code))
          .to be_instance_of(BrainzReleaseReference)
      end
    end
  end
end
