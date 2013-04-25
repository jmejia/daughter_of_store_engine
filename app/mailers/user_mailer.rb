class UserMailer < ActionMailer::Base
  default from: "no-reply@epicsale.com"

  def order_confirmation(user, order)
    @user = user
    @confirmation_code = order.confirmation

    mail to: user.email
  end

  def store_approval_confirmation(user, store)
    @user = user
    @store = store
    mail to: user.email
  end

  def store_decline_notification(user_email, store_name)
    @store_name = store_name
    mail to: user_email
  end

  def account_confirmation(user_email, full_name)
    @full_name = full_name
    mail to: user_email
  end

  def new_admin_notification(user, store)
    @store = store
    mail to: user.email
  end

  def signup_notification(invitee_email)
    mail to: invitee_email
  end

  def remove_admin_notification(user, store)
    @store = store
    @user = user
    mail to: user.email
  end

  def new_stocker_notification(user, store)
    @store = store
    mail to: user.email
  end

  def remove_stocker_notification(user, store)
    @store = store
    @user = user
    mail to: user.email
  end

  def monthly_invoice(store)
    @store = store
    @admin = store.admins.first
    @invoice = store.invoices.last
    mail to: store.admins.first.email
  end
end
