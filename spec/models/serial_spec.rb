require 'rails_helper'

RSpec.describe Serial, type: :model do
  before(:each) do
    @serial = FactoryGirl.create(:serial)
  end

  it "is valid with valid attributes" do
    expect(@serial).to be_valid
  end

  it "is not valid without a title" do
    @serial.title = nil
    expect(@serial).not_to be_valid
  end

  it "must have a unique name" do
    clone = Serial.new(title: @serial.title)
    expect(clone).not_to be_valid
  end

  it "must have a case insensitive unique name" do
    clone = Serial.new(title: @serial.title.upcase)
    expect(clone).not_to be_valid
  end

  it "is unique with a disambiguation" do
    clone = Serial.new(title: @serial.title, disambiguation: 'another serial')
    expect(clone).to be_valid
  end

  it "is not valid if a title disambiguation pair already exists" do
    disambiguation = 'same thing'
    @serial.disambiguation = disambiguation
    @serial.save!
    clone = Serial.new(title: @serial.title, disambiguation: disambiguation)
    expect(clone).not_to be_valid
  end
end
