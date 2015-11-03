require 'rails_helper'

RSpec.describe TrackDetail, type: :model do
  before(:each) do
    @attr = FactoryGirl.create(:track_detail)
  end

  it "is valid with valid attributes" do
    expect(@attr).to be_valid
  end

  it "is not valid without a track" do
    @attr.track = nil
    expect(@attr).not_to be_valid
    expect { @attr.save! validate: false }
      .to raise_error(/ERROR:  null value in column "track_id"/)
  end
  
  it "is not valid without a kind" do
    @attr.kind = nil
    expect(@attr).not_to be_valid
    expect { @attr.save! validate: false }
      .to raise_error(/ERROR:  null value in column "trf_attribute_kind_id"/)
  end
  
  it "is not valid without a no" do
    @attr.no = nil
    expect(@attr).not_to be_valid
    expect { @attr.save! validate: false }
      .to raise_error(/ERROR:  null value in column "no"/)
  end

  it "must have a unique pair of track_id and no" do
    clone = TrackDetail.new do |c|
      c.track = @attr.track
      c.kind  = @attr.kind
      c.no    = @attr.no
    end

    expect(clone).not_to be_valid
    expect { clone.save! validate: false }
      .to raise_error(/ERROR:  duplicate key value violates unique constraint "index_track_details_on_track_id_and_no"/)
  end
end
