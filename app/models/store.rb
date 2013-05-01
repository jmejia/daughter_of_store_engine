class Store < ActiveRecord::Base
  attr_accessible :description, :name, :slug, :status

  def payments(date_range)
    order_payments  = orders.where(:created_at => date_range).map(&:to_payment)
    refund_payments = refunds.where(:created_at => date_range).map(&:to_payment)
    order_payments + refund_payments
  end

  has_many :user_stores, dependent: :destroy
  has_many :users, through: :user_stores
  has_many :products, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :carts, dependent: :destroy
  has_many :invoices
  has_many :orders
  has_many :refunds, through: :orders

  validates_uniqueness_of :name, :slug
  validates_presence_of :name, :slug

  def monthly_invoice(start_date)
    end_date = start_date.end_of_month
    invoices.where(:start_date => start_date.beginning_of_day..end_date).first
  end

  def monthly_fee(start_date)
    monthly_orders = orders.where(
      :created_at => start_date.beginning_of_day..start_date.end_of_month
      )
    order_fee = monthly_orders.inject(0){ |sum, order| sum + order.total_cost }
    order_fee * GlobalFee.first.percentage
  end

  def admins
    User.joins(:user_stores).where(
      "user_stores.store_id = ? AND user_stores.role_id = ?",
      id, Role.admin.id
      )
  end

  def stockers
    User.joins(:user_stores).where(
      "user_stores.store_id = ? AND user_stores.role_id = ?",
      id, Role.stocker.id
      )
  end

  def admin(user_id)
    User.joins(:user_stores).where(%q{
    user_stores.store_id = ?
    AND user_stores.role_id = ?
    AND user_stores.user_id = ?}, id, Role.admin.id, user_id).first
  end

  def stocker(user_id)
    User.joins(:user_stores).where(%q{
    user_stores.store_id = ?
    AND user_stores.role_id = ?
    AND user_stores.user_id = ?}, id, Role.stocker.id, user_id).first
  end

  def add_admin(user)
    user_store = UserStore.new
    user_store.store = self
    user_store.role = Role.admin
    user_store.user = user
    user_store.save
  end

  def remove_admin(admin)
    user_store = user_stores.find_by_user_id(admin.id)
    if user_store
      user_store.destroy
    end
  end

  def remove_stocker(stocker)
    user_store = user_stores.find_by_user_id(stocker.id)
    if user_store
      user_store.destroy
    end
  end

  def add_stocker(user)
    user_store = UserStore.new
    user_store.store = self
    user_store.role = Role.stocker
    user_store.user = user
    user_store.save
  end

  def to_param
    slug
  end

  def pending?
    status == "pending"
  end

  def disabled?
    status == "disabled"
  end

  def approve_status
    self.status = "enabled"
    save
  end

  def decline_status
    UserStore.find_by_store_id(self.id).delete
    self.delete
  end

  def disable_status
    self.status = "disabled"
    save
  end

  def enable_status
    self.status = "enabled"
    save
  end

  def approved?
    !pending?
  end

  def enabled?
    status == "enabled"
  end

  def disabled?
    status == "disabled"
  end
end
