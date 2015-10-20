FactoryGirl.define do
  factory :pr_label do
    piece_release
    company

    factory :pr_label_with_catalog_no do
      sequence(:catalog_no) { |n| "catalog-##{n}" }
    end
  end

end
