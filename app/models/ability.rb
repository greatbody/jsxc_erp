class Ability
  include CanCan::Ability
  def initialize(user)
    if user.has_role? :superadmin
      can :manage, :all             # allow superadmins to do anything
    elsif user.has_role? :user
      can :manage, [Intention, ContactLog, ResidenceCard, Student, StudentSource, SourceContact]  # allow managers to do anything to products and users
      can [:assign_task, :search, :daily_sign], :service
    elsif user.has_role? :intern
      # can :cru, [Intention, ContactLog, ResidenceCard, Student]
      # can :get_intention_list_api, [Intention]
      can [:create, :read, :update, :get_intention_list], [Intention]
      can [:create, :read], [ContactLog]
      can [:create, :read], [Student]
      can [:search, :daily_sign], :service
    end
  end
end
