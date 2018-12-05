# frozen_string_literal: treu

require 'rails_helper'
require 'shared_examples_for_services'
require 'test_data/path_service'

RSpec.describe TestData::PathService do
  it_behaves_like 'a service'

  describe '.call' do
    context 'with a valid path' do
      path = 'musicbrainz.org/artist/bdacc37b-8633-4bf8-9dd5-4662ee651aec?' \
        'inc=artist-rels+url-rels.xml'
      it 'returns the file content' do
        expect(described_class.call(path)).to match(/\A<\?xml/)
      end
    end

    context 'when the file does not exist' do
      it 'raises an error' do
        expect { described_class.call('no/such/path') }
          .to raise_error(ArgumentError, /can't open/)
      end
    end
  end
end
