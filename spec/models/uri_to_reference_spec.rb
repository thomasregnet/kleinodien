require 'rails_helper'

RSpec.describe UriToReference do
  def uri_for(type)
    "https://musicbrainz.org/ws/2/artist/#{type}/fake-uuid?inc=foo-bar"
  end

  describe '.perform MusicBrainz uri' do
    context 'of an artist' do
      let(:uri) { uri_for(:artist) }

      it 'returns a BrainzArtistReference' do
        expect(described_class.perform(uri))
          .to be_instance_of(BrainzArtistReference)
      end
    end

    context 'of a release-group' do
      let(:uri) { uri_for('release-group') }

      it 'returns a BrainzArtistReference' do
        expect(described_class.perform(uri))
          .to be_instance_of(BrainzReleaseGroupReference)
      end
    end

    context 'of a release-group' do
      let(:uri) { uri_for(:release) }

      it 'returns a BrainzArtistReference' do
        expect(described_class.perform(uri))
          .to be_instance_of(BrainzReleaseReference)
      end
    end

    context 'of a unknown type' do
      it 'raises an error' do
        expect { described_class.perform(uri_for(:bad_type)) }
          .to raise_error(/bad_type/)
      end
    end
  end

  describe '.perform' do
    describe 'with a bad host' do
      it 'raises an error' do
        expect { described_class.perform('https://evil-host.org/foo/bar') }
          .to raise_error(/evil-host/)
      end
    end
  end
end
