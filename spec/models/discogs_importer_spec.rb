require 'rails_helper'

RSpec.describe DiscogsImporter, type: :model do
  before(:each) do
    @importer = DiscogsImporter.new
  end

  describe "import releases" do
    context "import a CD release of one artist"

    it "is a object" do
      expect(@importer).to be_instance_of(DiscogsImporter)
    end
  end
end
