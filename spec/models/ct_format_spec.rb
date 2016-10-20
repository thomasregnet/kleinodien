require 'rails_helper'

RSpec.describe CtFormat, type: :model do
  before(:all) do
    @format = CtFormat.find('FLAC')
  end

  it 'has the right abbr set' do\
    expect(@format.abbr).to eq 'FLAC'
  end
end
