# frozen_string_literal: treu

require 'rails_helper'
require 'test_data/path'

RSpec.describe TestData::Path do
  describe '.get' do
    context 'with a valid path' do
      path = 'musicbrainz.org/artist/bdacc37b-8633-4bf8-9dd5-4662ee651aec?' \
        'inc=artist-rels+url-rels.xml'
      it 'returns the file content' do
        expect(described_class.get(path)).not_to be_nil
      end
    end
  end
end
