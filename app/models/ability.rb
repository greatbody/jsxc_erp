class Ability
  include CanCan::Ability
  def initialize(user)
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

    # 校园CEO管理：刘犇
    if user.has_role? :manage_student_source

      can [:manage], [StudentSource, SourceContact]
      # can :cru, [Intention, ContactLog, ResidenceCard, Student]
      # can :get_intention_list_api, [Intention]
    end

    # 业务拓展：李德宽
    if user.has_role? :business_explorer
      can :manage, [TrainService, Coach, TrainField]
    end
  end
end
