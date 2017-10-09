FactoryGirl.define do
  factory :category do
    sequence(:name) { |i| "category_#{i}" }
  end
end