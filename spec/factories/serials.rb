FactoryGirl.define do
  factory :serial do
    sequence(:title) { |n| "serial ##{n}" }
    type 'Serial'

    factory :tv_serial, class: TvSerial do
      type 'TvSerial'

      factory :tv_serial_with_seasons, class: TvSerial do
        transient do
          seasons_count 3
        end

        after(:create) do |tv_serial, elevator|
          create_list(:season, elevator.seasons_count, serial: tv_serial)
        end
      end
    end
  end
end
