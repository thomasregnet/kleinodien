require 'rails_helper'
require 'fake_reference'

module Import
  # Fake a Import-service class for testing
  class FakeServiceClass < Import::Base
    def self.perform(args)
      new(args).perform
    end

    def perform
      {
        cache:      cache,
        reference: reference,
        params:     params
      }
    end
  end
end

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

  describe '#knowledge' do
    let(:base) { Import::Base.new }

    it 'retuns a Import::Knowledge object' do
      expect(base.knowledge).to be_instance_of(Import::Knowledge)
    end

    context '#ask' do
      it 'retuns an Import::Knowledge object' do
        expect(base.ask).to be_instance_of(Import::Knowledge)
      end
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

  describe '#reference' do
    it 'returns the reference' do
      reference = { just: 'a fake' }
      base = Import::Base.new(reference: reference)
      expect(base.reference).to eq reference
    end

    it "generates a reference if it's class is given" do
      base = Import::Base.new(
        params: params,
        reference_class: FakeReference
      )
      expect(base.reference.code).to eq(wanted)
    end
  end

  describe 'method_missing' do
    specify '#respond_to_missing?' do
      base = Import::Base.new
      expect(base.respond_to?('fake_service_class')).to be true
    end

    it 'does not respond to missing' do
      base = Import::Base.new
      expect(base.respond_to?(:no_such_class)).to be false
    end
  end
end
