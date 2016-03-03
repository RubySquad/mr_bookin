class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
      
    
    if user.role && user.role.name == 'Admin'
      # can :access, :rails_admin       # only allow admin users to access Rails Admin
      can :manage, :all             
    else
      
      alias_action :create, :read, :update, :to => :cru
      
      can :read, [Book, Category, Author]
      can :read, Rating, :approved => true
      can :bestsellers, Book
      can [:show_cart, :add_to_cart, :add_item, :clear_cart], Order, user_id: user.id
      can :destroy, OrderItem, order: { user_id: user.id }
      unless user.new_record?
        # can :dashboard                  # allow access to dashboard
        can [:read, :checkout], Order, user_id: user.id
        can :create, Rating
        if user.role.name == 'Manager'
          can :access, :rails_admin
          can :dashboard
          can :cru, [Book, Category, Author, Country, Order, OrderItem]
          can :update, User
          cannot :destroy, Order
          can :read, Rating
          can :destroy, OrderItem
          can :custom_order_edit, :all
          can :approve_review, Rating
          # cannot :clear_cart, Order, user_id: user.id
        elsif user.role.name == 'Customer'
          can :update, Order, user_id: user.id
          can :cru, :CreditCard
        end
      end  
    end
    #   if user.admin?
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
