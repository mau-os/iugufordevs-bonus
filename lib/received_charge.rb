class ReceivedCharge < Charge
  attr_accessor :payment_date, :status
  @@received_charges = []

  def initialize(token:, expiration_date:, amount:, payment_date:, status:)
    super(token: token, expiration_date: expiration_date, amount: amount)
    @payment_date = payment_date
    @status = status
    @@received_charges << self
  end

  def self.all
    @@received_charges
  end

  def self.sum
    @@received_charges.map(&:amount).sum
  end

  def self.clear
    @@received_charges = []
  end
end