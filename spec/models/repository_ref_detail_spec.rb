require 'rails_helper'

RSpec.describe RepositoryRefDetail, type: :model do
  before(:all) do
    DatabaseCleaner.start
    @detail = RepositoryRefDetail.new(
      repository: FactoryGirl.build(:repository),
      detail:     RefDetail.find('FLAC'),
      position:  0
    )
  end

  it 'is valid' do
    expect(@detail).to be_valid
  end

  it 'returns the abbr' do
    expect(@detail.abbr).to eq 'FLAC'
  end

  after(:all) do
    DatabaseCleaner.clean
  end
end
