class AdminAbility
  include CanCan::Ability
  def initialize(user)
    if user && user.has_role?(:superadmin)
      can :access, :rails_admin
      can :manage, :all
    else
      can :access, :rails_admin
      can :dashboard
    end
  end
end
