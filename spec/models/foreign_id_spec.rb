require "rails_helper"

RSpec.describe ForeignId do
  specify '#value' do
    foreign_id = ForeignId.new(value: '123')
    expect(foreign_id.value).to eq '123'
  end
end

