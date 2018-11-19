# frozen_string_literal: true

require 'rails_helper'
require 'ko_test_data'

RSpec.describe BrainzBlueprint do
  describe '.from_xml' do
    let(:xml) do
      KoTestData::GetBrainzXmlFor.path(
        'release/7452f8c9-f9bc-3ca7-859e-3220e57e4e4a?' \
          'inc=artists+labels+recordings+release-groups.xml'
      )
    end

    it 'returns the blueprint' do
      expect(described_class.from_xml(xml)).to be_instance_of described_class
    end
  end
end
