When(/^I define test data$/) do
  TestData.define(:brainz_arise) do |testset|
    testset.add(:brainz_release, '7452f8c9-f9bc-3ca7-859e-3220e57e4e4a')

    testset.define do |subset|
      subset.add(:brainz_release, '7452f8c9-f9bc-3ca7-859e-3220e57e4e4a')
    end
  end
end
