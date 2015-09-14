require 'rails_helper'

RSpec.describe CrfAttribute, type: :model do
  before(:each) do
    @attr = FactoryGirl.create(:crf_attribute)
  end

  it "is valid with valid attributes" do
    expect(@attr).to be_valid
  end

  it "is not valid without a format" do
    @attr.format = nil
    expect(@attr).not_to be_valid
    expect { @attr.save! validate: false }
      .to raise_error(/null value in column "cr_format_id"/)
  end
  
  it "is not valid without a kind" do
    @attr.kind = nil
    expect(@attr).not_to be_valid
    expect { @attr.save! validate: false }
      .to raise_error(/null value in column "crf_attribute_kind_id"/)
  end
  
  it "is not valid without a no" do
    @attr.no = nil
    expect(@attr).not_to be_valid
    expect { @attr.save! validate: false }
      .to raise_error(/null value in column "no"/)
  end

  it "must have a unique pair of format_id and no" do
    clone = CrfAttribute.new do |c|
      c.format = @attr.format
      c.kind   = @attr.kind
      c.no     = @attr.no
    end
    expect(clone).not_to be_valid
    expect { clone.save! validate: false }
      .to raise_error(
            /duplicate key.+"index_crf_attributes_on_cr_format_id_and_no"/
          )
  end
end
