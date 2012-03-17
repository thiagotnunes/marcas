class User < ActiveRecord::Base
  authenticates_with_sorcery!

  attr_accessible :username, :email, :password, :password_confirmation

  validates_confirmation_of :password

  validates_presence_of :username, :password, :email

  validates_length_of :username, :within => 3..20
  validates_length_of :password, :within => 6..30

  validates_uniqueness_of :username, :email

  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i

  def self.all_customers
    where("role = ?", "customer")
  end
  
  def admin?
    role == "admin"
  end

  def customer?
    role == "customer"
  end

  def active?
    activation_state == "active"
  end

end
