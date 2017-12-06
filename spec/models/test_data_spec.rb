require "rails_helper"

RSpec.describe TestData do
  describe '.define' do
    specify do
      expect { |b| described_class.define(:test, &b) }
        .to yield_with_args(TestSet)
    end
  end

  describe '.define' do
    described_class.define(:brainz_arise) do |set|
      set.add(:brainz_release, '7452f8c9-f9bc-3ca7-859e-3220e57e4e4a')
    end

    it 'returns the testset' do
      expect(described_class.fetch(:brainz_arise)).not_to be nil
    end
  end
end
