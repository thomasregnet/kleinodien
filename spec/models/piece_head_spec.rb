require 'rails_helper'

RSpec.describe PieceHead, type: :model do
  before(:each) do
    @ph = FactoryGirl.create(:piece_head)
  end

  it "is valid with valid attributes" do
    expect(@ph).to be_valid
  end

  it "is not valid without a title" do
    @ph.title = nil
    expect(@ph).not_to be_valid
  end

  it "is not valid without a type" do
    @ph.type = nil
    expect(@ph).not_to be_valid
  end

  it "must have a unique name" do
    clone = PieceHead.new(title: @ph.title, type: @ph.type)
    expect(clone).not_to be_valid
  end

  it "must have a case insensitive unique name" do
    clone = PieceHead.new(title: @ph.title.upcase, type: @ph.type)
    expect(clone).not_to be_valid
  end

  it "is valid and unique with disambiguation" do
    clone = PieceHead.new(title: @ph.title.upcase, type: @ph.type)
    clone.disambiguation = 'another one'
    expect(clone).to be_valid
  end

  it "is not valid if a title disambuguation pair already exists" do
    disambiguation = 'same thing'
    @ph.disambiguation = disambiguation
    @ph.save!
    clone = PieceHead.new(title: @ph.title, disambiguation: disambiguation)
    expect(clone).not_to be_valid
  end
end
