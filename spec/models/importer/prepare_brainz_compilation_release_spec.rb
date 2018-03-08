require 'rails_helper'
require 'fake_reference'

RSpec.describe Importer::PrepareBrainzCompilationRelease do
  it 'takes a reference' do
    prepare = described_class.new(
      reference: FakeReference.new(value: 'abc')
    )
    expect(prepare.reference).not_to be nil
  end
end
