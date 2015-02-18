require 'rails_helper'
require 'shared_examples_for_disambiguations'

RSpec.describe Artist, type: :model do
  before(:each) do
    @artist = FactoryGirl.create(:artist)
  end

  it_behaves_like "a model with disambiguations" do
    let(:factory) { :artist }
    let(:naming) { 'name' }
  end
  
  it "is valid with with valid attributes" do
    expect(@artist).to be_valid
  end

  # it "is not valid without a name" do
  #   @artist.name = nil
  #   expect(@artist).not_to be_valid
  # end

  # it "must have a unique name" do
  #   clone = Artist.new(name: @artist.name)
  #   expect { clone.save! }.to raise_error
  # end

  # it "must have a case insensitive unique name" do
  #   clone = Artist.new(name: @artist.name.upcase)
  #   expect { clone.save! }.to raise_error
  # end

  # it "is unique with a disambiguation" do
  #   clone = Artist.new(name: @artist.name, disambiguation: 'other one')
  #   expect { clone.save! }.not_to raise_error 
  # end

  # it "fails if a name-disambiguation pair already exists" do
  #   @artist = FactoryGirl.create(:artist_with_disambiguation)
  #   clone = Artist.new(
  #     name: @artist.name, disambiguation: @artist.disambiguation)
  #   expect { clone.save! }.to raise_error
  # end
end
