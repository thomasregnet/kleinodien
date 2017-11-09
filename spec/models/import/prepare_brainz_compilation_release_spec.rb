require 'rails_helper'
require 'fake_reference'

RSpec.describe Import::PrepareBrainzCompilationRelease do
  it 'takes a reference' do
    prepare = Import::PrepareBrainzCompilationRelease.new(
      reference: FakeReference.new(value: 'abc')
    )
    expect(prepare.reference).not_to be nil
  end

  it 'has the initialized the cache' do
    prepare = Import::PrepareBrainzCompilationRelease.new
    expect(prepare.cache).to be_instance_of(Import::Cache)
  end
end
