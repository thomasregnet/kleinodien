require 'rails_helper'

RSpec.describe IncompleteDate, type: :model do
  context "with a complete date" do
    before(:each) do
      @idate = IncompleteDate.new('2015-03-16')
    end

    it "returns a date-object" do
      expect(@idate.date).to be_instance_of(Date)
    end

    it "returns 7 as mask" do
      expect(@idate.mask).to eq(7)
    end
  end

  context "with a incomplete date" do
  end
end
