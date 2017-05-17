FactoryGirl.define do
  factory :brainz_release, class: 'BrainzRelease' do
    mbid SecureRandom.uuid.to_s
    sequence(:url) { |n| "http://fake/url#{n}" }
    data '<fake>data</fake>'
  end
end
