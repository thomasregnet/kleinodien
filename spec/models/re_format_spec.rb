require 'rails_helper'

RSpec.describe ReFormat, type: :model do
  context 'from db' do
    before(:all) do
      @format = ReFormat.find('CDr')
    end

    it 'has the right abbr' do
      expect(@format.abbr).to eq 'CDr'
    end

    it 'has the format set' do
      expect(@format.format.name).to eq 'CDr'
    end
  end

  context 'without a name' do
    before(:all) do
      @format = ReFormat.new
    end

    it 'is not valid' do
      expect(@format).not_to be_valid
    end
  end
end
