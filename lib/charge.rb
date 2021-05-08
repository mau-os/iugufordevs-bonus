require 'active_support/inflector'

class Charge
  attr_accessor :token, :expiration_date, :amount, :payment_method

  @@charges = []

  def initialize( token:, expiration_date:, amount:, payment_method:, payment_date: 0)
    @token = token
    @expiration_date = expiration_date
    @amount = amount
    @payment_method = payment_method.parameterize(separator: '_').upcase
    @payment_date = payment_date

    @@charges << self
  end

  def self.all
    @@charges
  end

  def self.all_payment_methods
    @@charges.map(&:payment_method).uniq
  end

  def self.list_by_payment_method(payment_method)
    all.select { |e| e.payment_method == payment_method}
  end

  def self.count_by_payment_method(payment_method)
    list_by_payment_method(payment_method).count
  end

  def self.sum_by_payment_method(payment_method)
    list_by_payment_method(payment_method).map(&:amount).sum
  end

  def self.clear
    @@charges = []
  end
end