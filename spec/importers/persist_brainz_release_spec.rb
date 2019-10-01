# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'
require 'test_data'

# rubocop:disable Metrics/BlockLength
RSpec.describe PersistBrainzRelease do
  it_behaves_like 'a service'

  def brainz_code
    '693748be-7c18-39c3-af2e-2e62092090cf'
  end

  def blueprint
    TestData.by_name(:brainz_release_the_sky_is_falling_gb_cd).blueprint
  end

  describe '.call' do
    context 'when the Release already exists' do
      before do
        FactoryBot.create(
          :release,
          brainz_code: brainz_code,
          title:       'Test Dummy'
        )
      end

      let(:import_request) do
        BrainzReleaseGroupImportRequest.new(code: brainz_code)
      end

      it 'returns the CompilationRelease' do
        proxy = spy
        allow(proxy).to receive(:get).and_return(blueprint)
        args = {
          blueprint:    blueprint,
          import_order: :fake,
          proxy:        proxy
        }
        expect(described_class.call(args).title).to eq('Test Dummy')
      end
    end
  end

  describe '#persist_release' do
    let(:import_request) do
      BrainzReleaseImportRequest.new(code: brainz_code)
    end

    let(:release) do
      persister = described_class.new(
        blueprint:      blueprint,
        import_order:   FactoryBot.create(:brainz_import_order),
        import_request: import_request,
        proxy:          :fake
      )

      allow(persister).to receive(:persist_artist_credit)
        .and_return(FactoryBot.create(:artist_credit))
      allow(persister).to receive(:blueprint)
        .and_return(blueprint)
      allow(persister).to receive(:persist_release_head)
        .and_return(FactoryBot.create(:release_head))

      persister.persist_release
    end

    it 'persists the release' do
      expect(release).not_to be_new_record
    end

    it 'sets the ImportOrder' do
      expect(release.import_order).not_to be_nil
    end
  end
end
# rubocop:enable Metrics/BlockLength
