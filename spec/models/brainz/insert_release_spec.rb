require 'rails_helper'
require 'brainz_test_helper'

RSpec.describe Brainz::InsertRelease, type: :model do
  context 'AC/DC - Highway to Hell' do
    before(:all) do
      DatabaseCleaner.start
      @brz_release = BrainzTestHelper
                     .get_release('c8f7094d-ce27-365e-961f-0af27321be08')
      @release = Brainz::InsertRelease.perform(@brz_release)
    end

    it 'works'
    
    after(:all) { DatabaseCleaner.clean }
  end
end
