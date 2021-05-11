require 'active_support/inflector'

class Charge
  attr_accessor :token, :expiration_date, :amount, :payment_method

  def initialize(token:, expiration_date:, amount:, payment_method:)
    @token = token
    @expiration_date = expiration_date
    @amount = amount
    @payment_method = payment_method.parameterize(separator: '_').upcase
  end

  def self.all_payment_methods(list)
    list.map(&:payment_method).uniq
  end

  def self.list_by_payment_method(payment_method:, list:)
    list.select { |e| e.payment_method == payment_method}
  end

  def self.count_by_payment_method(payment_method)
    list_by_payment_method(payment_method).count
  end

  def self.sum_by_payment_method(payment_method)
    list_by_payment_method(payment_method).map(&:amount).sum
  end
end