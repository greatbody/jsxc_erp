class AdminAbility
  include CanCan::Ability
  def initialize(user)
    if user
      if user.has_role?(:superadmin)
        can :access, :rails_admin
        can :manage, :all
      else
        if user.has_role?(:business_explorer)
          can :access, :rails_admin
          can :dashboard
          can :manage, [School, TrainField]
        end
      end
    end
  end
end
