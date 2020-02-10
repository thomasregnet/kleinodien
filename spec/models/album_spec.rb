# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Album, type: :model do
  it 'belongs_to :artist_credit' do
    album = FactoryBot.create(:album)
    album.artist_credit = FactoryBot.create(:artist_credit)
    expect { album.save! }.not_to raise_error

    association = described_class.reflect_on_association(:artist_credit)
    expect(association.macro).to eq(:belongs_to)
  end
end
