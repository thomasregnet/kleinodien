require 'rails_helper'

RSpec.describe RepositoryRefDetail, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  before(:all) do
    DatabaseCleaner.start
    @attr = RepositoryRefDetail.new(
      repository: FactoryGirl.build(:repository),
      attrib:     RefDetail.find('FLAC'),
      no:         0
    )
  end

  it 'works' do
    expect(@attr).to be_valid
  end

  after(:all) do
    DatabaseCleaner.clean
  end
end
