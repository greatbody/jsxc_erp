class Ability
  include CanCan::Ability
  def initialize(user)
    if user && user.admin?
      if user.role? :superadmin
        can :manage, :all             # allow superadmins to do anything
      elsif user.role? :manager
        can :manage, [User, Product]  # allow managers to do anything to products and users
      elsif user.role? :sales
        can :update, Product, :hidden => false  # allow sales to only update visible products
      end
    else
      can :dashboard
    end
  end
end
