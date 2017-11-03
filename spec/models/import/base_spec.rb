require 'rails_helper'
require 'fake_foreign_id'

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

  describe '#cache' do
    it 'has the cache initialized' do
      base = Import::Base.new
      expect(base.cache).to be_instance_of(Import::Cache)
    end

    it 'can take the cache as an argument' do
      cache = Import::Cache.new
      base = Import::Base.new(cache: cache)
      expect(base.cache).to eq(cache)
    end
  end

  describe '#params' do
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

  describe '#foreign_id' do
    it 'returns the foreign_id' do
      foreign_id = { just: 'a fake' }
      base = Import::Base.new(foreign_id: foreign_id)
      expect(base.foreign_id).to eq foreign_id
    end

    it "generates a foreign_id if it's class is given" do
      base = Import::Base.new(
        params: params,
        foreign_id_class: FakeForeignId
      )
      expect(base.foreign_id.value).to eq(wanted)
    end
  end
end
