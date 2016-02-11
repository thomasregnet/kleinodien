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

    specify '#artist_credit_name' do
      expect(@release.head.artist_credit.name).to eq 'AC/DC'
    end

    specify '#title' do
      expect(@release.title).to eq 'Highway to Hell'
    end

    specify '#date' do
      expect(@release.date.to_s).to eq '1979-07-27'
    end
    
    after(:all) { DatabaseCleaner.clean }
  end
end
