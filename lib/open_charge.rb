require 'active_support/inflector'

class OpenCharge < Charge
  attr_accessor :payment_method

  @@open_charges = []

  def initialize(token:, expiration_date:, amount:, payment_method:)
    super(token: token, expiration_date: expiration_date, amount: amount)
    @payment_method = payment_method.parameterize(separator: '_').upcase
    @@open_charges << self
  end

  def self.all
    @@open_charges
  end

  def self.all_payment_methods
    @@open_charges.map(&:payment_method).uniq
  end

  def self.list_by_payment_method(payment_method)
    @@open_charges.select { |e| e.payment_method == payment_method}
  end

  def self.count_by_payment_method(payment_method)
    list_by_payment_method(payment_method).count
  end

  def self.sum_by_payment_method(payment_method)
    list_by_payment_method(payment_method).map(&:amount).sum
  end

  def to_file
    "#{token}#{expiration_date}        #{"%010d" % amount}01"
  end

  def self.clear
    @@open_charges = []
  end
end