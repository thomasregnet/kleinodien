require "rails_helper"

RSpec.describe TestData do
  describe '.define' do
    specify do
      expect { |b| described_class.define(:test, &b) }
        .to yield_with_args(TestSet)
    end
  end

  describe '.retrieve' do
    described_class.define(:brainz_arise) do |test_set|
      # TODO: currently the set.add line does not make sense. Delete it?
      test_set.add(:brainz_release, '7452f8c9-f9bc-3ca7-859e-3220e57e4e4a')
    end

    context 'with a valid test-set name' do
      it 'returns the test set' do
        expect(described_class.retrieve(:brainz_arise))
          .to be_instance_of(TestSet)
      end
    end

    context 'with an  invalid test-set name' do
      it 'raises an ArguemtnError' do
        expect { described_class.retrieve(:unknown_stuff) }
          .to raise_error(ArgumentError)
      end
    end
  end
end
