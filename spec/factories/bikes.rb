FactoryGirl.define do
  factory :bike do
    sequence(:name) { |i| "bike_#{i}" }
    sequence(:description) { |j| "description for bike_#{j}"}
    association(:category)
    association(:user)
    used_bike ""
  end
end
