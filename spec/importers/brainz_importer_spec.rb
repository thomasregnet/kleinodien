# frozen_string_literal: true

require 'rails_helper'

# TODO: specs for BrainzImporter
RSpec.describe BrainzImporter do
  context 'release' do
    it 'foo' do
      # TODO: make a real test of this
      allow(ImportBrainzRelease).to receive(:call)
    end
  end
end
