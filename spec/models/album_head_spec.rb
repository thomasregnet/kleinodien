# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_disambiguations'

RSpec.describe AlbumHead, type: :model do
  it 'is valid with valid attributes' do
    expect(FactoryBot.build(:album_head)).to be_valid
  end

  it 'is not valid without an artist_credit' do
    # @album_head.artist_credit = nil
    album_head = FactoryBot.build(:album_head, artist_credit: nil)
    expect(album_head).not_to be_valid
  end

  it_behaves_like 'a model with disambiguations' do
    let(:factory) { :album_head }
    let(:object)  { FactoryBot.build(:album_head) }
    let(:naming)  { 'title' }
  end
end
