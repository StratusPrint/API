class UserAbility
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
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
    if user.admin?
      can :manage, :all
    else
      can :read, :all
      can :create, Job
      cannot :manage, User

      # Custom Actions
      can :show_statistics, Hub
      can :start, Printer
      can :pause, Printer
      can :cancel, Printer
      can :show_current_job, Printer
      can :show_queued_jobs, Printer
      can :show_processing_jobs, Printer
      can :show_completed_jobs, Printer
      can :show_recent_jobs, Printer
      can :create, Command
      can :show_statistics, Hub
    end
  end
end
