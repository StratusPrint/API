class HubAbility
  include CanCan::Ability

  def initialize(hub)
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

    # The abilities defined below allow a hub to manage itself and its child
    # resources, namely: printers, print jobs, sensors, and sensor data. More importantly,
    # the definitions prevent a hub from modifying resources which do not belong to it.
    # For example, if a hub tries to modify or view a sensor that belongs to another hub
    # in the system, access is denied and a 403 error is returned. This allows the system
    # to securely manage multiple deployments, each with its own hub and set of sensors
    # and printers.

    # Allow hub to log sensor data
    # and create new printers, jobs, and sensors
    can [:create], [DataPoint, Job, Printer, Sensor]

    # Allow hub to read and update existing
    # sensor data
    can [:read, :update], DataPoint do |dp|
      dp.sensor.hub.id == hub.id
    end

    # Allow hub to read and update existing
    # printer jobs
    can [:read, :update], Job do |j|
      j.printer.hub.id == hub.id
    end

    # Allow hub to read and update existing
    # sensors
    can [:read, :update], Sensor do |s|
      s.hub.id == hub.id
    end

    # Allow hub to read and update existing
    # printers
    can [:read, :update], Printer do |p|
      p.hub.id == hub.id
    end

    # Allow hub to read its own profile
    can :show, Hub, :id => hub.id
  end
end
