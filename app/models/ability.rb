class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :update, :destroy, :to => :modify

    can :read, :all
    if user.present?
      can :manage, RootPost, user_id: user.id
      can :manage, ChildPost, user_id: user.id
      # can :manage, Room
      if user.admin?
        can :manage, :all
      end
    end
  end
end
