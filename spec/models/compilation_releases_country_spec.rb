require 'rails_helper'

RSpec.describe CompilationReleasesCountry, type: :model do
  describe "the combination of Release and Country must be unique" do
    before(:each) do
      @country = FactoryGirl.create(:country)
      @release = FactoryGirl.create(:album_release)
      @release_country = CompilationReleasesCountry.create!(
        country:             @country,
        compilation_release: @release,
      )
    end

    it "fails when the combination of country and release already exists" do
      other_release_country = CompilationReleasesCountry.new(
        country:             @country,
        compilation_release: @release,
      )
      expect(other_release_country).not_to be_valid
    end
  end
end
