class OpenCharge < Charge
  @@open_charges = []

  def initialize(**param)
    super(**param)
    @@open_charges << self
  end

  def self.all
    @@open_charges
  end

  def self.all_payment_methods
    super(@@open_charges)
  end

  def self.list_by_payment_method(payment_method)
    super(payment_method: payment_method, list: @@open_charges)
  end

  def to_file
    "#{token}#{expiration_date}        #{"%010d" % amount}01"
  end

  def self.clear
    @@open_charges = []
  end
end