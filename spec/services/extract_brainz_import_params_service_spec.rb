require 'rails_helper'
require 'shared_examples_for_services'

RSpec.describe ExtractBrainzImportParamsService do
  it_behaves_like 'a service'

  def code
    '74292121-e345-3f10-85ae-013f4e5a8cae'
  end

  def kind
    'release-group'
  end

  def web_uri_string
    ['https://musicbrainz.org/release-group', code, kind].join('/')
  end

  context 'with a valid non ws uri' do
    let(:result) { described_class.call(URI(web_uri_string)) }

    it 'returns the expected code' do
      expect(result[:code]).to eq('74292121-e345-3f10-85ae-013f4e5a8cae')
    end

    it 'returns the expected kind' do
      expect(result[:kind]).to eq('release-group')
    end
  end
end
