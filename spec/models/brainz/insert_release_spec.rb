# coding: utf-8
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

  describe 'Judgment Night' do
    before(:all) do
      DatabaseCleaner.start
      @brz_release = BrainzTestHelper
                     .get_release('f966b30a-a0bc-4234-bea6-7b93a1083276')
      @release = Brainz::InsertRelease.perform(@brz_release)
    end

    context '#head.artist_credits' do
      specify '#name' do
        expect(@release.head.artist_credit.name).to eq 'Various Artists'
      end
    end

    context '#tracks' do
      specify 'artist_credit' do
        expect(@release.tracks[5].piece.head.artist_credit.name)
          .to eq 'Faith No More & Boo‐Yaa T.R.I.B.E.'
      end
    end

    after(:all) { DatabaseCleaner.clean }
  end
end
