class Charge
  attr_accessor :token, :expiration_date, :amount

  def initialize(token:, expiration_date:, amount:)
    @token = token
    @expiration_date = expiration_date
    @amount = amount
  end
end