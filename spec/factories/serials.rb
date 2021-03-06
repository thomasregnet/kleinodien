# frozen_string_literal: true

FactoryBot.define do
  factory :serial do
    sequence(:title) { |n| "serial ##{n}" }
    type { 'Serial' }

    factory :tv_serial, class: 'TvSerial' do
      type { 'TvSerial' }

      factory :tv_serial_with_seasons, class: 'TvSerial' do
        transient do
          seasons_count { 3 }
        end

        after(:create) do |tv_serial, evaluator|
          create_list(:season, evaluator.seasons_count, serial: tv_serial)
        end
      end
    end

    factory :podcast_serial, class: 'PodcastSerial' do
      type { 'PodcastSerial' }
    end
  end
end
