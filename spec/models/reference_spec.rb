require "rails_helper"

RSpec.describe Reference do
  specify '#code' do
    reference = Reference.new(code: '123')
    expect(reference.code).to eq '123'
  end

  specify '#to_key' do
    reference = Reference.new(code: 'abc', kind: 'some-kind')
    expect(reference.to_key). to eq('some-kind/abc')
  end
end

