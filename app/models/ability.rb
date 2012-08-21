class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :manage,          ConsolidatedTax, :user_id => user.id
    can :manage,          Customer,        :user_id => user.id
    can :manage,          Option,          :user_id => user.id
    can :manage,          Estimate,        :customer => { :user_id => user.id }, :consolidated_tax => { :user_id => user.id }
    cannot :update, Estimate do |e|
      e.consolidated_tax.user_id != user.id
    end
    can :manage,          Invoice,         :customer => { :user_id => user.id }
    can :manage,          InvoiceProject,  :customer => { :user_id => user.id }
    can :manage,          RecurringSlip,   :customer => { :user_id => user.id }
    can :create,          RecurringSlip
    can :manage,          Slip,            :customer => { :user_id => user.id }
    can :manage,          Tax,             :consolidated_tax => { :user_id => user.id }
    can :edit,            User,            :id => user.id
    can :update,          User,            :id => user.id
    can :password_edit,   User,            :id => user.id
    can :password_update, User,            :id => user.id
  end
end
