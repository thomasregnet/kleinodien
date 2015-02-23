require 'rails_helper'
require 'shared_examples_for_disambiguations'

RSpec.describe TvSerial, type: :model do

  context "without seasons" do
    before(:each) do
      @tv_serial = FactoryGirl.create(:tv_serial)
    end

    it "is valid with valid attributes" do
      expect(@tv_serial).to be_valid
    end

    it_behaves_like "a model with disambiguations" do
      let(:factory) { :tv_serial }
      let(:object) { @tv_serial }
      let(:naming) { 'title' }
    end
  end
end
