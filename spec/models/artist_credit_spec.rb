require 'rails_helper'

RSpec.describe ArtistCredit, type: :model do
  before(:each) do
    FactoryGirl.create(:artist_credit)
  end

  it "is valid with valid attributes"

  it "is not valid without a name"
end
