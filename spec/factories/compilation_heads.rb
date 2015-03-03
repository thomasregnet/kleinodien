FactoryGirl.define do
  factory :compilation_head do
    sequence(:title) { |n| "compilation head ##{n}" }
    type 'CompilationHead'
  end

end
