require "rails_helper"

RSpec.describe TestData do
  describe '.define' do
    TestData.define(:brainz_arise) do |set| 
      set.add(:brainz_release, '7452f8c9-f9bc-3ca7-859e-3220e57e4e4a')
    end

    it 'returns the testset' do
      expect(described_class.fetch(:brainz_arise)).not_to be nil
    end
  end

  describe '#add' do
    let(:test_data) { described_class.new(:test_set) }

    context 'with valid data' do
      let(:brainz_code) { '7452f8c9-f9bc-3ca7-859e-3220e57e4e4a' }

      it 'returns the right reference' do
        expect(test_data.add(:brainz_release, :brainz_code))
          .to be_instance_of(BrainzReleaseRef)
      end
    end

    context 'with an invalid kind' do
      it 'raises an ArrgumentError' do
        expect { test_data.add(:horst_seehofer, 'abc') }
          .to raise_error(ArgumentError)
      end
    end
  end
end
