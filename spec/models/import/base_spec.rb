require "rails_helper"

RSpec.describe Import::Base do
  def wanted
    'abc123'
  end

  def params
    Hash[
      data: {
        type: 'some-test-data',
        attributes: {
          wanted: wanted
        }
      }
    ] 
  end
  it 'has the cache initialized' do
    base = Import::Base.new
    expect(base.cache).to be_instance_of(Import::Cache)
  end

  it 'can take the cache as an argument' do
    cache = Import::Cache.new
    base = Import::Base.new(cache: cache)
    expect(base.cache).to eq(cache)
  end

  it 'can take params as an argument' do
    base = Import::Base.new(params: params)
    expect(base.params).to eq params
  end

  it 'returns the wanted id if correct params are given' do
    base = Import::Base.new(params: params)
    expect(base.wanted).to eq(wanted)
  end

  it 'without params it returns nil for "wanted"' do
    base = Import::Base.new
    expect(base.wanted).to be nil
  end
end
