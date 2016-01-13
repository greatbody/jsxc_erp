class Ability
  include CanCan::Ability
  def initialize(user)
    # binding.remote_pry
    if user.has_role? :superadmin
      can :manage, :all
    end

    if user.has_role? :user
      can :manage, [Intention, ContactLog, ResidenceCard, Student, StudentSource, SourceContact]  # allow managers to do anything to products and users
      can [:read, :update], [Coach]
      can [:assign_task, :search, :daily_sign], :service
    end

    if user.has_role? :intern
      can [:create, :read, :update, :get_intention_list], [Intention]
      can [:create, :read], [ContactLog]
      can [:create, :read, :signed_up, :wait_pay], [Student]
      can [:search, :daily_sign], :service
    end

    if user.has_role? :manage_student_source
      # binding.remote_pry
      can [:manage], [StudentSource, SourceContact]
      # can :cru, [Intention, ContactLog, ResidenceCard, Student]
      # can :get_intention_list_api, [Intention]
    end
  end
end
