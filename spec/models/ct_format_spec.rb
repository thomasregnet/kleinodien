require 'rails_helper'

RSpec.describe CtFormat, type: :model do
  before(:all) do
    @format = CtFormat.find_by(name: 'FLAC')
  end

  it 'has the right name set' do
    expect(@format.name).to eq 'FLAC'
  end
end
