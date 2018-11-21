# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

RSpec.describe BrainzFetcher do
  it_behaves_like 'a service'

  context 'with a valid ImportOrder' do
    def brainz_code
      '2280ca0e-6968-4349-8c36-cb0cbd6ee95f'
    end

    let(:uri) do
      'https://musicbrainz.org/ws/2/artist/' \
        + brainz_code \
        + '?inc=url-rels'
    end

    let(:import_request) do
      FactoryBot.build(
        :brainz_artist_import_request,
        code: brainz_code
      )
    end
    it 'returns a BrainzBlueprint' do
      # import_request = instance_double('Fake ImportRequest')
      # allow(import_request).to receive_messages(to_uri: uri, processing: true)
      # allow(import_request).to receive_messages('save!' => true)
      # allow(import_request).to receive_messages(done: true, 'save!' => true)

      expect(described_class.call(import_request: import_request))
        .to be_instance_of(BrainzBlueprint)
    end
  end

  # TODO: uncomment this
  # context "when data can't be requested" do
  #   let(:uri) { 'https://musicbrainz.org/can/not/be/found' }

  #   it 'raises an error' do
  #     import_request = instance_double('Fake ImportRequest')
  #     allow(import_request).to receive_messages(to_uri: uri, processing: true)
  #     allow(import_request).to receive_messages('save!' => true)
  #     allow(import_request).to receive_messages(failed: true)
  #     allow(import_request).to receive_messages('save!' => true)

  #     expect { described_class.call(import_request: import_request) }
  #       .to raise_error(ImportError::CanNotFetch, /#{uri}/)
  #   end
  # end
end
