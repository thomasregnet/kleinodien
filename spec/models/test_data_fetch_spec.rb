require 'rails_helper'

RSpec.describe TestDataFetch do
  context 'with existing data' do
    let(:reference) do
      BrainzArtistReference.from_code('1d93c839-22e7-4f76-ad84-d27039efc048')
    end

    it 'returns the content' do
      expect(described_class.perform(reference)).to match(/^<\?xml/)
    end
  end

  context 'with non existing data' do
    let(:reference) do
      BrainzArtistReference.from_code('nosuch-data-4f76-ad84-d27039efc048')
    end

    it 'raises' do
      expect { described_class.perform(reference) }
        .to raise_error(Errno::ENOENT)
    end
  end
end
