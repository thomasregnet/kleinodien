FactoryBot.define do
  factory :ph_label do
    piece_head
    company

    factory :ph_label_with_catalog_no do
      sequence(:catalog_no) { |n| "catalog-##{n}" }
    end
  end
end
