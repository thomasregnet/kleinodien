require "rails_helper"

RSpec.describe Reference do
  specify '#code' do
    foreign_id = Reference.new(code: '123')
    expect(foreign_id.code).to eq '123'
  end
end

