FactoryBot.define do
  factory :cr_label do
    compilation_release
    company

    factory :cr_label_with_catalog_no do
      sequence(:catalog_no) { |n| "catalog-##{n}" }
    end
  end
end
