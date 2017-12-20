require 'test_data'

TestData.define :brainz_sepultura_arise do |test_set|
  test_set.add(:brainz_release, '7452f8c9-f9bc-3ca7-859e-3220e57e4e4a')

  test_set.define do |subset|
    subset.add(:brainz_artist, '1d93c839-22e7-4f76-ad84-d27039efc048')
  end
end
