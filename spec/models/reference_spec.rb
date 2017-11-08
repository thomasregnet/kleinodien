require "rails_helper"

RSpec.describe Reference do
  specify '#value' do
    foreign_id = Reference.new(value: '123')
    expect(foreign_id.value).to eq '123'
  end
end

