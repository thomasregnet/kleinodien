require 'rails_helper'

RSpec.describe Station, type: :model do
  before(:each) do
    @station = FactoryGirl.create(:station)
  end

  it "is valid with valid parameters" do
    expect(@station).to be_valid
  end

  it "is not valid without a name" do
    @station.name = nil
    expect(@station).not_to be_valid
  end

  it "must have a unique name" do
    clone = Station.new(name: @station.name, type: @station.type)
    expect { clone.save! }.to raise_error
  end

  it "must have a case insensitive unique name" do
    clone = Station.new(name: @station.name.upcase, type: @station.type)
    expect { clone.save! }.to raise_error
  end

  it "is unique with a disambiguation" do
    clone = Station.new(name: @station.name,
                        disambiguation: 'other one',
                        type: @station.type)
    expect { clone.save! }.not_to raise_error 
  end

  it "fails if a name-disambiguation pair already exists" do
    #@station = FactoryGirl.create(disambiguation: 'other one')
    clone = Station.new(name: @station.name,
                        disambiguation: @station.disambiguation,
                        type: @station.type)
    expect(clone).not_to be_valid
  end
end
