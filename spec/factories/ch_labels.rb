FactoryGirl.define do
  factory :ch_label do
    compilation_head
    company

    factory :ch_label_with_catalog_no do
      sequence(:catalog_no) { |n| "catalog-##{n}" }
    end
  end
end
