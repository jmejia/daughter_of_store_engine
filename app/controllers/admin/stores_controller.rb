class Admin::StoresController < ApplicationController
  load_and_authorize_resource
  before_filter :store, except: [:index]

  def index
    if current_user && current_user.platform_administrator
      @stores = Store.order("name")
    else
      redirect_to root_path
    end
  end

  def show
    @store = Store.find_by_slug(params[:store_slug])
    @invoice = @store.invoices.last

    if current_user && (@store.users.include?(current_user) || current_user.platform_administrator)
      render :show
    else
      redirect_to home_path(@store)
    end
  end

  def activate
    authorize! :manage, Store
    if store.approve_status
      UserMailer.delay.store_approval_confirmation(@store.users.first, @store)
      redirect_to admin_stores_path, notice: "#{@store.name} has been approved."
    else
      flash[:errors] = "We're sorry. There was a problem approving #{store.name}."
      redirect_to admin_stores_path
    end
  end

  def new_admin
    render :new_admin
  end

  def remove_admin
    admin = @store.admin(params[:id])

    if admin && @store.admins.count > 1
      @store.remove_admin(admin)
      UserMailer.delay.remove_admin_notification(admin, @store)
      redirect_to admin_home_path(@store),notice:"The admin has been removed"
    elsif @store.admins.count == 1
      flash[:error] = "There must be at least one admin"
      redirect_to admin_home_path(@store)
    else
      flash[:error] = "There was problem removing the admin"
      redirect_to admin_home_path(@store)
    end
  end

  def new_stocker
    render :new_stocker
  end

  def remove_stocker
    stocker = @store.stocker(params[:id])

    if stocker
      @store.remove_stocker(stocker)
      UserMailer.delay.remove_stocker_notification(stocker, @store)
      redirect_to admin_home_path(@store),notice:"The stocker has been removed"
    else
      flash[:error] = "There was problem removing the stocker"
      redirect_to admin_home_path(@store)
    end
  end

  def create_stocker
    new_stocker = User.find_by_email(params[:email])
    store = Store.find_by_slug(params[:store_slug])

    if new_stocker && store.add_stocker(new_stocker)
      UserMailer.delay.new_stocker_notification(new_stocker, @store)
      redirect_to admin_home_path(params[:store_slug])
    elsif new_stocker.nil?
      UserMailer.delay.signup_notification(params[:email])
      redirect_to admin_home_path(params[:store_slug])
    else
      render :new_stocker,
        notice: "We're sorry. There was a problem adding #{params[:email]}"
    end
  end

  def create_admin
    new_admin = User.find_by_email(params[:email])
    store = Store.find_by_slug(params[:store_slug])

    if new_admin && store.add_admin(new_admin)
      UserMailer.delay.new_admin_notification(new_admin, @store)
      redirect_to admin_home_path(params[:store_slug])
    elsif new_admin.nil?
      UserMailer.delay.signup_notification(params[:email])
      redirect_to admin_home_path(params[:store_slug])
    else
      render :new_admin,
      notice: "We're sorry. There was a problem adding #{params[:email]}"
    end
  end

  def decline
    authorize! :manage, Store
    #@store = Store.find(params[:store_id])
    user = store.users.first
    if store.decline_status
      redirect_to admin_stores_path, notice: "The status for #{store.name} has been set to 'declined' and a message has been sent to #{user.email}."
      UserMailer.delay.store_decline_notification(user.email, store.name)
    else
      flash[:errors] = "We're sorry. There was a problem declining #{store.name}."
      redirect_to admin_stores_path
    end
  end

  def disable
    authorize! :manage, Store
    if store.disable_status
      redirect_to :back, notice: "#{store.name} has been disabled."
      store = Store.find_by_slug(params[:store_id])
      store.admins.each do |admin|
        UserMailer.delay.store_disabled(store, admin)
      end
    else
      flash[:errors] = "We're sorry. There was a problem disabling #{store.name}."
      redirect_to admin_stores_path
    end
  end

  def enable
    authorize! :manage, Store
    store = Store.find_by_slug(params[:store_id])
    if store.enable_status
      redirect_to :back, notice: "#{store.name} has been enabled."
    else
      flash[:errors] = "We're sorry. There was a problem disabling #{store.name}."
      redirect_to admin_stores_path
    end
  end

  private
  def store
    @store ||= Store.find_by_slug(params[:store_id])
  end
end
