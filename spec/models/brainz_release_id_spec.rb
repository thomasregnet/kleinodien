require 'rails_helper'
require 'shared_examples_for_brainz_release_source_id'

RSpec.describe BrainzReleaseId do
  describe '.source_id' do
    it_behaves_like 'a brainz release source id' do
      let(:source_id) { BrainzReleaseId.source_id(SecureRandom.uuid) }
    end
  end

  describe '#source_id' do
    it_behaves_like 'a brainz release source id' do
      brainz_release_id = BrainzReleaseId.new(value: SecureRandom.uuid)
      let(:source_id) { brainz_release_id.source_id }
    end
  end
end
