# frozen_string_literal: true

require 'rails_helper'
require 'test_data/base'

RSpec.describe TestData::Base do
  describe '.raw' do
    context 'with a valid path' do
      let(:base) do
        path = 'musicbrainz.org/artist/bdacc37b-8633-4bf8-9dd5-4662ee651aec?' \
          'inc=artist-rels+url-rels.xml'

        described_class.new(path: path)
      end

      it 'returns the file content' do
        expect(base.raw).to match(/\A<\?xml/)
      end
    end

    context 'when the file does not exist' do
      let(:base) { described_class.new(path: 'no/such/path') }

      it 'raises an error' do
        expect { base.raw }
          .to raise_error(ArgumentError, /can't open/)
      end
    end
  end
end
