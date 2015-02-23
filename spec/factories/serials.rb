FactoryGirl.define do
  factory :serial do
    sequence(:title) { |n| "serial ##{n}" }
    type 'Serial'

    factory :tv_serial, class: TvSerial do
      type 'TvSerial'
    end
  end
end
