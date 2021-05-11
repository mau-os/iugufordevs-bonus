class ReceivedCharge < Charge
  @@received_charges = []

  def initialize(token:, expiration_date:, amount:, payment_method:, payment_date: 0)
    super(token: token, expiration_date: expiration_date, amount: amount, payment_method: payment_method)
    @payment_date = payment_date
    @@received_charges << self
  end

  def self.all
    @@received_charges
  end

  def self.all_payment_methods
    super(@@received_charges)
  end

  def self.list_by_payment_method(payment_method)
    super(payment_method: payment_method, list: @@received_charges)
  end

  def self.clear
    @@received_charges = []
  end
end