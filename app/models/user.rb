class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :orders

  has_many :user_stores, dependent: :destroy
  has_many :stores, :through => :user_stores
  has_many :roles, :through => :user_stores

  attr_accessible :full_name, :display_name, :email, :password,
                  :platform_administrator, :password_confirmation, :role,
                  :stripe_customer_token

  validates_presence_of :full_name, on: :create
  validates_confirmation_of :password
  validates_presence_of :password, on: :create
  validates_presence_of :email
  validates_uniqueness_of :email,
  :message => "Email is already associated with an account. Login <a href='/login'>here.</a>"

  ROLES = ["admin", "user"]

  def to_s
    full_name
  end

  def role?(role)
    self.role == role.to_s
  end
end
