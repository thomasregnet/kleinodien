# frozen_string_literal: true

require 'ko_test_data'
require 'rails_helper'
require 'shared_examples_for_services'

RSpec.describe PersistBrainzCompilationRelease do
  it_behaves_like 'a service'

  describe '.call' do
    context 'when the CompilationRelease already exists' do
      before do
        FactoryBot.create(
          :compilation_release,
          brainz_code: '693748be-7c18-39c3-af2e-2e62092090cf',
          title:       'Test Dummy'
        )
      end

      let(:blueprint) do
        xml_string = KoTestData::GetBrainzXmlFor.path(
          'release/693748be-7c18-39c3-af2e-2e62092090cf' \
            '?inc=artists+labels+recordings+release-groups.xml'
        )
        BrainzBlueprint.from_xml(xml_string)
      end

      it 'returns the CompilationRelease' do
        expect(described_class.call(blueprint: blueprint).title)
          .to eq('Test Dummy')
      end
    end
  end
end
