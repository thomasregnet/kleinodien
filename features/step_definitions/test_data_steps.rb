def artist_ref # Jello Biafra
  BrainzArtistReference.from_code('2280ca0e-6968-4349-8c36-cb0cbd6ee95f')
end

def release_ref # Sepultura - Arise
  BrainzReleaseReference.from_code('7452f8c9-f9bc-3ca7-859e-3220e57e4e4a')
end

When(/^I define test data$/) do
  TestData.define(:brainz_arise) do |testset|
    testset.add(:brainz_release, release_ref.code )

    testset.define do |subset|
      subset.add(:brainz_artist, artist_ref.code)
    end
  end
end

Then(/^I can retrieve that data$/) do
  test_set = TestData.retrieve(:brainz_arise)
  expect(test_set.fetch(artist_ref)).to be nil
  expect(test_set.fetch(release_ref)).to match(/Arise/)

  subset = TestData.retrieve(:brainz_arise, 0)
  #expect(subset.fetch(release_ref)).to match(/Arise/)
  expect(subset.fetch(artist_ref)).to match(/Biafra, Jello/)
end
