FactoryGirl.define do
  factory :album_release do
    association :head, factory: :album_head
  end

end
