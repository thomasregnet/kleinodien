require 'rails_helper'
require 'shared_examples_for_brainz_release_source_id'

RSpec.describe BrainzReleaseRef do
  before(:all) do
    @foreign_id = BrainzReleaseRef.new(code: uuid)
  end

  def query_string
    '?inc=artists+labels+recordings+release-groups'
  end

  def uuid
    'c2cbe953-df42-4be2-b829-8abc9ad01809'
  end

  # TODO: delete source_id
  describe '.source_id' do
    it_behaves_like 'a brainz release source id' do
      let(:source_id) { BrainzReleaseRef.source_id(SecureRandom.uuid) }
    end
  end

  describe '#source_id' do
    it_behaves_like 'a brainz release source id' do
      brainz_release_id = BrainzReleaseRef.new(code: SecureRandom.uuid)
      let(:source_id) { brainz_release_id.source_id }
    end
  end

  describe '#ref_key' do
    it 'returns the ref_key' do
      expected = "release/#{uuid}#{query_string}"
      expect(@foreign_id.to_key).to eq(expected)
    end
  end
end
