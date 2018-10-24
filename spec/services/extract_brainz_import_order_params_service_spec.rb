require 'rails_helper'
require 'shared_examples_for_services'
require 'shared_examples_for_import_params_services'

RSpec.describe ExtractBrainzImportOrderParamsService do
  it_behaves_like 'a service'

  def code
    '74292121-e345-3f10-85ae-013f4e5a8cae'
  end

  def kind
    'release-group'
  end

  def web_uri
    URI(
      ['https://musicbrainz.org/release-group', code, kind].join('/')
    )
  end

  # Web-service (/ws/2)
  def api_uri
    URI(
      ['https://musicbrainz.org/ws/2/release-group', code, kind].join('/')
    )
  end

  it_behaves_like 'an import params service' do
    let(:uri)           { web_uri }
    let(:expected_code) { code }
    let(:expected_kind) { kind }
  end

  it_behaves_like 'an import params service' do
    let(:uri)           { api_uri }
    let(:expected_code) { code }
    let(:expected_kind) { kind }
  end
end
