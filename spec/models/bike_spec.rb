require 'rails_helper'

describe Bike do
  # Bike.delete_all
  it "validates the bike and makes sure it's not empty" do
    bike = Bike.new(name: "", description: 'desc1', user_id: 1, used_bike: '', category_id: 2)
    bike.valid?
    expect(bike.errors[:name]).to_not be_empty
  end

  it "check count bikes for user" do
    bike1 = create(:bike, user_id: 1)
    bike2 = create(:bike, user_id: 2)
    bike3 = create(:bike, user_id: 3)
    bike4 = create(:bike, user_id: 1)
    bike5 = create(:bike, user_id: 2)

    user1_bikes = Bike.where(user_id: 1)
    user3_bikes = Bike.where(user_id: 3)
    expect(user1_bikes.count).to eq(2)
    expect(user3_bikes.count).to eq(1)
  end

end
