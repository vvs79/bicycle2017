class BikesMailer < ApplicationMailer
  def bike_edit(bike, user)
    @bike = bike
    @user = user ? user.email : 'no user'
    mail to: @user + ',vidoc1979@gmail.com', subject: "Bike need to check"
  end
end
