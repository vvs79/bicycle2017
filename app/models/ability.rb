class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.has_role? :admin
      can :manage, :all
    elsif user.has_role? :user
      can [:create, :update, :destroy, :read], [Bike, Comment]
    else
      can :read, Bike
    end 
  end
end
