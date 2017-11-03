require 'rails_helper'
require 'fake_foreign_id'

RSpec.describe Import::PrepareBrainzCompilationRelease do
  it 'takes a foreign_id' do
    prepare = Import::PrepareBrainzCompilationRelease.new(
      foreign_id: FakeForeignId.new(value: 'abc')
    )
    expect(prepare.foreign_id).not_to be nil
  end

  it 'has the initialized the cache' do
    prepare = Import::PrepareBrainzCompilationRelease.new
    expect(prepare.cache).to be_instance_of(Import::Cache)
  end
end
