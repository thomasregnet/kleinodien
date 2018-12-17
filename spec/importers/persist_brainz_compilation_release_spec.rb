# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'
require 'test_data'

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
        TestData.by_name(:brainz_release_the_sky_is_falling_gb_cd).blueprint
      end

      it 'returns the CompilationRelease' do
        expect(described_class.call(blueprint: blueprint).title)
          .to eq('Test Dummy')
      end
    end
  end
end
