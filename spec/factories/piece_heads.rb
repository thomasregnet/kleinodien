FactoryGirl.define do
  factory :piece_head do
    sequence(:title) { |n| "piece ##{n}" }
    type  'PieceHead' 
  end
end
