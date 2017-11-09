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

  describe '#to_key' do
    it 'returns the ref_key' do
      expected = "release/#{uuid}#{query_string}"
      expect(@foreign_id.to_key).to eq(expected)
    end
  end
end
