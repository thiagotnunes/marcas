class OrderStatus < ActiveRecord::Base
  LIFECYCLES = {
    :manual => 'manual',
    :first => 'first',
    :during_payment => 'during_payment',
    :after_payment => 'after_payment'
  }

  has_many :trademark_orders

  validates_presence_of :status, :color, :lifecycle

  validates_length_of :status, :within => 3..50

  validates_uniqueness_of :status

  validate :validate_lifecycle

  def self.find_first
    first(:conditions => ["lifecycle = '#{LIFECYCLES[:first]}'"])
  end

  def self.find_during_payment
    first(:conditions => ["lifecycle = '#{LIFECYCLES[:during_payment]}'"])
  end

  def self.find_after_payment
    first(:conditions => ["lifecycle = '#{LIFECYCLES[:after_payment]}'"])
  end

  private

  def validate_lifecycle
    errors.add(:lifecycle, t('errors.messages.invalid')) unless LIFECYCLES.include? lifecycle.to_sym
  end
end
