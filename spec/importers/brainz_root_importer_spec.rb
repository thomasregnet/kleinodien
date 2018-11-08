# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BrainzRootImporter do
  context 'release' do
    it 'foo' do
      # TODO: make a real test of this
      allow(BrainzReleaseImporter).to receive(:from_import_order)
    end
  end
end
