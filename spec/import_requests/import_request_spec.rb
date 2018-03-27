require 'rails_helper'

RSpec.describe ImportRequest do
  it { is_expected.to respond_to(:code) }
  it { is_expected.to respond_to(:importer_class) }
  it { is_expected.to respond_to(:reference_class) }
  it { is_expected.to respond_to(:requested) }

  describe '.brainz_release' do
    let(:import_request) { described_class.brainz_release(code: 'abc') }

    it 'has the importer_class set' do
      expect(import_request.importer_class).to eq('ImportBrainzReleaseService')
    end

    it 'has the reference_class set' do
      expect(import_request.reference_class)
        .to eq('BrainzReleaseReference')
    end

    it 'has the code set' do
      expect(import_request.code).to eq('abc')
    end
  end
end
